package iuh.fit.nguyenbaodinh_23731621_bai5_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai5_tuan04.dao.DepartmentDAO;
import iuh.fit.nguyenbaodinh_23731621_bai5_tuan04.model.Department;
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

@WebServlet("/departments")
public class DepartmentServlet extends HttpServlet {

    @Resource(name="jdbc/employee_db")
    private DataSource dataSource;

    private DepartmentDAO deptDao;

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);

        try {
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
                String keyword = req.getParameter("keyword");

                List<Department> departments;

                if (keyword != null && !keyword.trim().isEmpty()) {
                    departments = deptDao.searchByName(keyword.trim());
                    req.setAttribute("keyword", keyword.trim());
                }
                else {
                    departments = deptDao.getAll();
                }

                req.setAttribute("departments", departments);
                req.getRequestDispatcher("/view/department-list.jsp").forward(req, resp);
                break;


            case "new":
                req.getRequestDispatcher("/view/department-form.jsp").forward(req, resp);
                break;


            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));

                Department department = deptDao.getById(id);

                if (department != null) {
                    req.setAttribute("department", department);
                    req.getRequestDispatcher("/view/department-form.jsp").forward(req, resp);
                }
                else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Department not found");
                }

                break;


            case "delete":
                int deptId = Integer.parseInt(req.getParameter("id"));

                try {
                    deptDao.delete(deptId);
                    resp.sendRedirect(req.getContextPath() + "/departments");
                }
                catch (Exception e) {
                    resp.sendRedirect(req.getContextPath() + "/departments?error=departmentHasEmployees");
                }

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

        Department department = new Department(id, name);

        if (id > 0) {
            deptDao.update(department);
        }
        else {
            deptDao.save(department);
        }

        resp.sendRedirect(req.getContextPath() + "/departments");
    }
}