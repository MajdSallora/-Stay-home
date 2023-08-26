class AppUrl {
  AppUrl._();

  static const baseUrl = "http://finalstayhome-001-site1.atempurl.com";

  //refresh tokem
  static const refreshToken = "";

  // login
  static const login = "Driver/LogIn";

  //profile
  static const modify = "Driver/Modify";
  static const getAllVehicleTypes = 'Driver/GetAllVehicleTypes';

  // order
  static const getAllAssigned = 'Order/GetAllAssigned';
  static const getByIdShippingOrder = 'Order/GetByIdShippingOrder';
  static const getByIdDeliveryOrder = 'Order/GetByIdDeliveryOrder';
  static const getByIdPassengerOrder = 'Order/GetByIdPassengerOrder';
  static const accept = "Order/Accept";
  static const cancel = "Order/Cancel";
  static const complete = "Order/Complete";
  static const getAllEvaluated = 'Order/GetAllEvaluated';
  static const getAllDelivered = 'Order/GetAllDelivered';
  static const getOrderOnWay = 'Order/GetOrderOnWay';
  
}
