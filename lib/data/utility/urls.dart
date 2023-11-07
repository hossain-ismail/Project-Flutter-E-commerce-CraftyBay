class Urls{
  static const String _baseUrl = 'https://ecom-api.teamrabbil.com/api';
  static String verifyEmail(String email) => '$_baseUrl/UserLogin/$email';
  static String verifyOtp(String email,String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static const String getHomeSlider ='$_baseUrl/ListProductSlider';
  static const String getCategories ='$_baseUrl/CategoryList';
  static String getProductByCategory(int categoryId)=>'$_baseUrl/ListProductByCategory/$categoryId';
  static String getProductByRemarks(String remark) => '$_baseUrl/ListProductByRemark/$remark';
  static String getProductDetails(int productId) => '$_baseUrl/ProductDetailsById/$productId';
  static const String addToCart ='$_baseUrl/CreateCartList';
  static const String getCartList = '$_baseUrl/CartList';
  static  String getDeleteCartListItem(int productId) => '$_baseUrl/DeleteCartList/$productId';
  static const String postProductReview = '$_baseUrl/CreateProductReview';
  static  String getProductReview(int productId) => '$_baseUrl/ListReviewByProduct/$productId';
  static  String getCreateWishList(int productId) => '$_baseUrl/CreateWishList/$productId';
  static const String productWishList = '$_baseUrl/ProductWishList';
  static  String getRemoveWishList(int productId) => '$_baseUrl/RemoveWishList/$productId';
  static const String createProfile ='$_baseUrl/CreateProfile';
  static  String readProfile(String token) =>'$_baseUrl/ReadProfile?=$token';
  static String removeFromCart(int id)=>'$_baseUrl/DeleteCartList/$id';
  static const String createInvoice = '$_baseUrl/InvoiceCreate';
  static const String invoiceList = '$_baseUrl/InvoiceList';

}