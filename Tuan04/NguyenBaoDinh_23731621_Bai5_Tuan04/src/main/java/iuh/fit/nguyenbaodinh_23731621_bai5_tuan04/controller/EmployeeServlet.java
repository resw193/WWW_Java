package iuh.fit.nguyenbaodinh_23731621_bai5_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai5_tuan04.dao.DepartmentDAO;
import iuh.fit.nguyenbaodinh_23731621_bai5_tuan04.dao.EmployeeDAO;
import iuh.fit.nguyenbaodinh_23731621_bai5_tuan04.model.Employee;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    @Resource(name="jdbc/employee_db")
    private DataSource dataSource;

    private EmployeeDAO empDao;
    private DepartmentDAO deptDao;

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);

        try {
            empDao = new EmployeeDAO(dataSource);
            deptDao = new DepartmentDAO(dataSource);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "list":
                // Load toàn bộ employees
                List<Employee> allEmployees = empDao.getAllEmployees();

                req.setAttribute("employees", allEmployees);

                req.getRequestDispatcher("/view/employee-list.jsp").forward(req, resp);
                break;


            case "new":
                // Load danh sách phòng ban cho combobox
                req.setAttribute("departments", deptDao.getAll());

                // Nếu thêm nhân viên từ một phòng ban cụ thể
                String newDeptId = req.getParameter("deptId");

                if (newDeptId != null && !newDeptId.isEmpty()) {
                    req.setAttribute("selectedDeptId", Integer.parseInt(newDeptId));
                }

                req.getRequestDispatcher("/view/employee-form.jsp").forward(req, resp);
                break;


            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));

                // Lấy nhân viên cần sửa
                Employee emp = empDao.getById(id);

                if (emp != null) {
                    req.setAttribute("employee", emp);
                    req.setAttribute("departments", deptDao.getAll());

                    req.getRequestDispatcher("/view/employee-form.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Employee not found");
                }

                break;


            case "delete":
                int empId = Integer.parseInt(req.getParameter("id"));

                // Lấy employee trước khi xóa để biết department
                Employee employeeDelete = empDao.getById(empId);

                empDao.delete(empId);

                if (employeeDelete != null && employeeDelete.getDepartmentId() > 0) {
                    resp.sendRedirect(req.getContextPath() + "/employees?action=viewbyid&deptId=" + employeeDelete.getDepartmentId());
                } else {
                    resp.sendRedirect(req.getContextPath() + "/employees");
                }

                break;


            case "viewbyid":
                // Hiển thị nhân viên theo phòng ban
                String deptId = req.getParameter("deptId");
                List<Employee> list;

                if (deptId != null && !deptId.isEmpty()) {
                    int departmentId = Integer.parseInt(deptId);

                    list = empDao.getAllByDepartment(departmentId);

                    req.setAttribute("currentDeptId", departmentId);
                }
                else {
                    list = empDao.getAllByDepartment(1);

                    req.setAttribute("currentDeptId", 1);
                }

                req.setAttribute("employees", list);
                req.setAttribute("departments", deptDao.getAll());

                req.getRequestDispatcher("/view/employee-list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idParam = req.getParameter("id");

        int id;

        if (idParam != null && !idParam.isEmpty()) {
            id = Integer.parseInt(idParam);
        }
        else {
            id = 0;
        }

        String name = req.getParameter("name");
        double salary = Double.parseDouble(req.getParameter("salary"));
        int deptId = Integer.parseInt(req.getParameter("departmentId"));

        Employee emp = new Employee(id, name, deptId, salary);

        if (id > 0) {
            empDao.update(emp);
        } else {
            empDao.save(emp);
        }

        resp.sendRedirect(req.getContextPath() + "/employees?action=viewbyid&deptId=" + deptId);
    }
}