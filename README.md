### 1. CRUD 끝내기 (non scaffold)

**RESTful** 하게 짜기! (posts 컨트롤러, post 모델!)

RESTful이란, 주소창(url)을 통해서 자원(리소스)과 행위(HTTP Verb)를 표현하는 것.

[가장 깔끔한 설명](http://meetup.toast.com/posts/92)

-  routes.rb 에서의 setting

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

   ```ruby
   gem 'carrierwave', '~> 1.0'
   ```

   ```
   $ bundle install
   ```

2. 파일업로더 생성

   ```
   $ rails generate uploader Avatar
   ```

3. 서버 작업

- migration : string 타입의 column 추가

- `post.rb`

  ```ruby
  mount_uploader :컬럼명, AvatarUploader
  ```

- `posts_controller.rb`

  ```ruby
  # strong parameter에 받아주거나, create 단계에서 사진 받을 준비
  ```

- `new.html.erb`

  ```ruby
  <form enctype="multipart/form-data">
    <input type="file" name="post[postimage]">
  </form>

  <%= form_tag ("/posts", method: "post", multipart: true) do %>
    <%= file_field_tag("post[postimage]") %><br />
  <% end %>
  ```

  ​