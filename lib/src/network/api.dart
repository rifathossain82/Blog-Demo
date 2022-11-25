class API {
  static const _baseUrl = 'https://apiv1.techofic.com/app/techofice';

  static String get getAllBlogs => '$_baseUrl/get-all-blog-list';
  static getBlogDetails({required blogId}) => '$_baseUrl/get-blog-details/$blogId';
  static String get createBlog => '$_baseUrl/create-blog';
  static String get updateBlog => '$_baseUrl/update-blog';
  static deleteBlog({required blogId}) => '$_baseUrl/remove-blog/$blogId';
  static String get uploadImage => '$_baseUrl/upload-image';
  static String get addRemoveFavoriteBlog => '$_baseUrl/update-favorite-blog';
  static String get getAllFavoriteBlogs => '$_baseUrl/get-favourite-blog-list';
}