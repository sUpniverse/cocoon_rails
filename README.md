### 1. CRUD 끝내기 (non scaffold)

**RESTful** 하게 짜기! (posts 컨트롤러, post 모델!)

- RESTful이란, 주소창(url)을 통해서 자원(리소스)과 행위(HTTP Verb)를 표현하는 것.

  [가장 깔끔한 설명](http://meetup.toast.com/posts/92)

-  routes.rb 에서의 Setting

  ```ruby
    # index
    get '/posts' => 'posts#index'
    # Create
    get '/posts/new' => 'posts#new'
    post '/posts'=> 'posts#create'
    # Read
    get '/posts/:id' => 'posts#show'
    # Update
    get '/posts/:id/edit' => 'posts#edit'
    put '/posts/:id' => 'posts#update'
    # Delete
    delete '/posts/:id' => 'posts#destroy'
  ```

- controller에서의 추가 기능들

  - [filter](http://guides.rorlab.org/action_controller_overview.html#%ED%95%84%ED%84%B0) (기존의 find들을 private안에 넣어두고 중복해서 사용하지 않고 가져다쓴다. )

    ```ruby
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    private
    def set_post
      @post = Post.find(params[:id])
    end
    ```

    - 전역변수의 느낌? set_post를 통해 post의 변수를 선언하고 가져다쓴다.
    - Before_action을 통해서 set_post의 영역을 먼저 실행한다.
    - only를 통해 white List를 만들어서 관리

  - [strong parameters](http://guides.rorlab.org/action_controller_overview.html#strong-parameters) (server단에서 **필요한 query값**만 받아들이는것)

    ```ruby
    private

    def post_params
      params.require(:post).permit(:title, :content)
    end
    ```

- view - form_tag / form_for

  - [폼 헬퍼](http://guides.rorlab.org/form_helpers.html)


### 2. scaffolding을 통해  편하게 CRUD 하기 (중수로 나아가기)

 1.  `rails new app `명령어를 통해 rails 파일을 생성한다.

 2.  `scaffold` 명령어를 통해서 CRUD를 만든다

     ```
     $ rails g scaffold post title:string content:text
     ```

3. `routes.rb`

     ```ruby
     resources :posts
     ```



### 3. [파일업로드](https://github.com/carrierwaveuploader/carrierwave)

1. gemfile

   ```
   gem install carrierwave -v "1.0.0"
   ```

   ```ruby
   # gem 파일안에 추가해준다
   gem 'carrierwave', '~> 1.0'
   ```

   ```
   $ bundle install
   ```

2. 파일업로더 생성

   ```
   $ rails generate uploader Avatar(업로더 이름)
   ```

   1. 이러면 `app/uploaders/avatar_uploader.rb`  가 생성된다.

3. 서버 작업

- migration : string 타입의 column 추가

- `post.rb`

  ```ruby
  mount_uploader :컬럼명, AvatarUploader (업로더 이름)
  ```

- `posts_controller.rb`

  - strong parameter에 받아주거나, create 단계에서 사진 받을 준비

- `new.html.erb`

  ```ruby
  <form enctype="multipart/form-data">
    <input type="file" name="post[postimage]">
  </form>
  ```

  ```ruby
  <%= form_tag ("/posts", method: "post", multipart: true) do %>
    <%= file_field_tag("post[postimage]") %><br />
  <% end %>
  ```

  - 위 처럼 form태그를 변경가능하다 아래쪽을 나중엔 더 많이 쓴다.


### 4. 회원가입 

- `devise`  회원 가입을 위한 gem [devise](https://github.com/plataformatec/devise)

  ```ruby
  gem 'devise'
  ```

- 프로젝트에 적용

  ```
  $ rails generate devise:install
  ```

- `app/views/layouts/application.html.erb`에 manual에 나온 코드를 삽입

  ```ruby
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>
  ```

  - flash처럼 무엇인가 notice줄때 해당하는 뷰를 만들어 놓은것 (기능상엔 이미 구현되어 있다)

- User model을 생성해준다

  ```
  $ rails generate devise user(MODEL)
  $ rake db:migrate
  ```

- 기능 구현 완료!! 다음은 session을 이용하여 log in이 되지 않으면 _sign_in 으로 보내기

  ```ruby
  before_action :authenticate_user!
  ```

  - `exception: [:index]` 등을 추가해서 검증을 제외할 것들을 추가하면 된다
  - 자세한것은 [authenticate_user!](https://stackoverflow.com/questions/17911046/before-filter-authenticate-user-except-index-rails-4)

- User의 속성을 변경해보자 (간단버전, 아래에 customizing을 위한 version 탑재)

  ```ruby
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
  end

  ```

  - `ApplicationController`에 해당 코드를 삽입한다. 
  - username을 넣기위한 [방법](https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address)

- ##### Customizing 하기

  - controller 수정하기

    ```
    $ rails generate devise:controllers users
    ```

    - `users/` 밑에 많은 하위 controller가 생김 

    - 실행하면 그 다음으로 `routes.rb`와 여러가지를 변경하라고 메세지가 나옴

      ```ruby
      devise_for :users, controllers: {
        # 각 해당 되는 controller들을 routes에 등록하여준다.
        sessions: 'users/sessions'
        registrations: 'users/registrations'
        }
      ```

    - `users/` 하위 파일들의 설정들을 필요로함 

  - view 수정하기

    ```
    $ rails generate deviese:views
    ```

    - `app/views/devise` 라는 폴더가 생성된다.  

  - colum 수정하기

    - `db/migrate` 에 원하는 정보로 수정
    - 해당 view에서 data input을 위한 코드 수정
    - strong parameter를 설정 (controller 생성 or  `application_controller.rb`)

- Admin 생성하기

  ```
  $ rails generate migration add_admin_to_users admin:boolean
  ```

  - admin model을 수정한다

    ```ruby
    class AddAdminToUsers < ActiveRecord::Migration
      def change
        add_column :users, :admin, :boolean, default: false
      end
    end
    ```

  - 요렇게 `db/add_admin_to_users` 에 보면 나와있다. 

- cancancan

  ```ruby
  gem 'cancancan', '~> 2.0'
  ```

  - 자동으로 권한을 부여해주는 `gem`

  - 받았으면 `bundle install`하고  적용한다

    ```
    $ rails g cancan:ability
    ```

    - `models/ability`가 생성되고 그 안을 [Defining Abilites](https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities)한다.

      ```ruby
      class Ability
        include CanCan::Ability
        def initialize(user)
          can :read, :all 
          if user.present?  
            can :manage, Post, user_id: user.id 
            if user.admin?  
              can :manage, :all
            end
          end
        end
      end
      ```

  - 사용법 :  `can`  또는 `cannot`을 통해 viewes와 controllers에서 적용한다

    ```ruby
    # views의 show.html.erb 수정 버튼에 적용된 예시
    <% if can? :update, @article %>
      <%= link_to "Edit", edit_article_path(@article) %>
    <% end %>
    ```

    ```ruby
    # controller에 적용된 예시 
    class ArticlesController < ApplicationController
      load_and_authorize_resource param_method: :my_sanitizer

      def create
        if @article.save
          # hurray
        else
          render :new
        end
      end

      private

      def my_sanitizer
        params.require(:article).permit(:name)
      end
    end
    ```

    ​

