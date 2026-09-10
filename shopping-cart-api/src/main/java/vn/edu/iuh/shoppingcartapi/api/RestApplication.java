package vn.edu.iuh.shoppingcartapi.api;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;


// Context path: /shopping-cart-api
// API path: /api
// Do đó URL gốc là:
// http://localhost:8080/shopping-cart-api/api
@ApplicationPath("/api")
public class RestApplication extends Application {

}
