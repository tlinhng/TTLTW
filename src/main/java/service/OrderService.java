package service;

import db.JDBIConnector;
import model.Invoice;
import model.Order;
import model.OrderDetail;
import model.Permission;
import model.RolePermission;
import model.User;
import response.InvoiceResponse;
import response.OrderOrderdetailResponse;

import java.util.List;
import java.util.stream.Collectors;

public class OrderService {

//	laay danh sach 
    public static List<Order> getData() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select * from orders").mapToBean(Order.class)
                    .stream().collect(Collectors.toList());
        });
    }

    // them order
    public static int addOrder(Order input) {
        input.setStatus(1);
        return insertOrder(input);
    }

    public static int insertOrder(Order input) {
    	System.out.println("----insert order-----");
    	System.out.println(input.toString());
        // query > insert
        String query = "INSERT INTO orders(`iduser`,`idaddress`,`subtotal`,`itemdiscount`,`shipping`,`idcoupons`,`grandtotal`,`status`,`content`) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, input.getIduser())
                    .bind(1, input.getIdaddress())
                    .bind(2, input.getSubtotal())
                    .bind(3, input.getItemdiscount())
                    .bind(4, input.getShipping())
                    .bind(5, input.getIdcoupons())
                    .bind(6, input.getGrandtotal())
                    .bind(7, input.getStatus())
                    .bind(8, input.getContent())
                    .executeAndReturnGeneratedKeys()
                    .mapTo(Integer.class)
                    .findOnly();
        });
    }

    // cập nhật lại mã code trong orders

    public static Order updateCodeUser(int idcoupons, int idorders) {

        String query = "UPDATE orders SET idcoupons = ? WHERE idorders = ?";
        // String query = " SELECT code FROM coupons where
        // idcoupons = 1";

        // return JDBIConnector.get().withHandle(handle -> {
        // return handle.createQuery(query)
        // .bind(0, idcoupons)
        // .bind(1, iduser)
        // .mapToBean(Order.class).stream().collect(Collectors.toList());
        // });

        List<Order> datas = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idcoupons)
                    .bind(1, idorders)
                    .mapToBean(Order.class).stream().collect(Collectors.toList());
        });
        return datas.get(0);

    }

    // cập nhật số lượng

    public static Order updateQuantity(int idorders) {

        String query = "UPDATE orders SET quantity = ? WHERE idorders = ?";

        List<Order> datas = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery(query)

                    .bind(0, idorders)
                    .mapToBean(Order.class).stream().collect(Collectors.toList());
        });
        return datas.get(0);

    }

    // xoa 1 san phamr
    public static Order getDeleteOne(int idorders) {

        String query = "delete from orders where idorder = ?";
        List<Order> datas = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idorders)
                    .mapToBean(Order.class).stream().collect(Collectors.toList());
        });
        return datas.get(0);
    }
    
    // lấy chi tiết 1 theo id cuar san pham
    public static Order getDetailByOrderId(int idorder) {
        String query = "SELECT * FROM orders where idorders = ?";
        List<Order> datas = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idorder).mapToBean(Order.class).stream().collect(Collectors.toList());
        });
        if (datas.size() > 0) {
            if (datas.size() != 1)
                return null;
            return datas.get(0);// lấy duy nhất 1 sản phẩm
        }
        return null;
    }


    
//	public static List<OrderOrderdetailResponse> getDetailOrderByIdOrder(int idinvoice) {
//		return JDBIConnector.get().withHandle(handle -> {
//			return handle.createQuery(
//					"select o.idorders as idorder , o.iduser, d.idproduct, d.content, i.idinvoice from  invoice i  join orders o on o.idorders=i.idorder join orderdetail d on o.idorders=d.idorders where i.idinvoice=?")
//					.bind(0, idinvoice).mapToBean(OrderOrderdetailResponse.class).stream().collect(Collectors.toList());
//		});
//	}
//    
	public static List<Order> getDetailOrderByIdOrder1(int idorder) {
		return JDBIConnector.get().withHandle(handle -> {
			return handle.createQuery(
					"select * from orders where idorders=?")
					.bind(0, idorder).mapToBean(Order.class).stream().collect(Collectors.toList());
		});
	}
	
	

    
    public static void main(String[] args) {

        List<Order> data = getData();
        System.out.println(data);

//        Order order = new Order(2, 3, 100000, 20000, 5000, 1, 120000, 1, "");
        Order order = new Order(4, 3, 4000000, 20000, 0, 1, 20000, 1, "");
        int insertId= insertOrder(order);
        System.out.println(insertId);

    }
}
