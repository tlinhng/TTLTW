package controller.admin;

import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfWriter;
import model.Order;
import model.OrderDetail;
import model.User;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.event.DocumentListener;
import javax.swing.event.UndoableEditListener;
import javax.swing.text.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ExportFilePDFOrderController", value = "/chi-tiet-don-hang/exportFilePDFOrder")
public class ExportFilePDFOrderController extends HttpServlet {
    OrderService orderService = new OrderService();

    UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        int intId = Integer.parseInt(id);
        Order order = orderService.getDetailByOrderId(intId);
        User info = userService.getDetailUserByIdUser(order.getIduser());
        List<OrderDetail> orderDetailList = OrderDetailService.getProductCategory(order.getIdorder());

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=\"don-hang-" + order.getIdorder() + ".pdf\"");



        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        HtmlConverter.convertToPdf(toStringHtml(info, order, orderDetailList), outputStream);

        resp.setContentLength(outputStream.size());
        ServletOutputStream servletOutputStream = resp.getOutputStream();
        outputStream.writeTo(servletOutputStream);
        servletOutputStream.flush();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    private static String toStringHtml(User info, Order order, List<OrderDetail> list) {
        String html = "<!DOCTYPE html> \n" +
                "                <html>\n" +
                "                <head>\n" +
                "                <title>Đơn hàng</title>\n" +
                "                <style>\n" +
                "                body {\n" +
                "                 font-family: Arial, sans-serif;\n" +
                "                 margin: 20px;\n" +
                "                }\n" +
                "                \n" +
                "                h1 {\n" +
                "                margin-bottom: 10px;\n" +
                "                }\n" +
                "                \n" +
                "                table {\n" +
                "                width: 100%;\n" +
                "                border-collapse: collapse;\n" +
                "                 margin-bottom: 20px;\n" +
                "                 }\n" +
                "                \n" +
                "               th, td {\n" +
                "                border: 1px solid #ccc;\n" +
                "                 padding: 8px;n" +
                "                text-align: center; /* Canh giữa dữ liệu */\n" +
                "                }\n" +
                "                \n" +
                "                th {\n" +
                "                background-color: #f2f2f2;\n" +
                "                font-weight: bold;\n" +
                "                }\n" +
                "                \n" +
                "                tr:nth-child(even) {\n" +
                "                 background-color: #f9f9f9;\n" +
                "                }\n" +
                "               \n" +
                "                      tr:hover {\n" +
                "                          background-color: #e6e6e6;\n" +
                "                      }\n" +
                "                 </style>\n" +
                "               </head>\n" +
                "                <body>\n" +
                "                  <h2>Thông tin khách hàng</h2>\n" +
                "                <table>\n" +
                "                    <tr>\n" +
                "                   <th>Tên khách hàng</th>\n" +
                "                    <th>Số điện thoại</th>\n" +
                "                    <th>Email</th>\n" +
                "               </tr>\n" +
                "             <tr>\n" +
                "<td>"+ info.getFirstname()+" "+info.getLastname()+"</td>\n" +
                "<td>"+info.getPhone()+"</td>\n" +
                "<td>"+info.getEmail()+"</td>\n" +
                "   </tr>\n" +
                "              </table>\n" +
                "               \n" +
                "                   <h2>Thông tin đơn hàng</h2>\n" +
                " <h4> Mã đơn hàng:" + order.getIdorder() +"\n" +
                "                    <table>\n" +
                "                        <tr>\n" +
                "                            <th>Mã sản phẩm</th>\n" +
                "                           <th>Tên sản phẩm</th>\n" +
                "                          <th>Số lượng</th>\n" +
                "                           <th>Size</th>\n" +
                "                          <th>Giá bán</th>\n" +

                "                       </tr>\n";
        for (OrderDetail o : list) {
            if (o.getIdorder() == order.getIdorder()) {
                int idProduct = o.getIdproduct();
                String nameProduct = ProductService.getNameById(o.getIdproduct());
                int quantity = o.getQuantity();
                String size = o.getSize();
                float discount = o.getDiscount();
                html += "<tr>\n" +
                        "<td>" + idProduct + "</td>\n" +
                        "<td>" + nameProduct + "</td>\n" +
                        "<td>" + quantity + "</td>\n" +
                        "<td>" + size + "</td>\n" +
                        "<td>" + discount + "</td>\n" +
                        "</tr>\n";
            }
        }
        html += "</table>\n" +
                "<h2> Tổng tiền: " + order.getGrandtotal() + "</h2>\n" +
                "</body>\n" +
                "</html>\n";
        return html;
            }
        }