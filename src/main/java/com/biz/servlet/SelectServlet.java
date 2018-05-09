package com.biz.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.biz.model.Student;
import com.biz.redis.DBSave;
import com.biz.dao.StudentDao;

/**
 * Servlet implementation class SelectServlet
 */
@WebServlet("/SelectServlet")
public class SelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public SelectServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Student> list = new ArrayList<Student>();
		int indexPage = 1 ;			//��ǰҳ
		int targetPage = 1 ;		//Ŀ��ҳ
		int pageNumber = 1 ;		//ҳ������
		int start = 0 ;			//��ʼ�����±�
		int end = 0 ;		//���������±�
		
		try {
			if(request.getParameter("flag") == "") {
				new StudentDao().SelectAll();
			}
			list = DBSave.getList() ;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(list.size() > 10) {
			pageNumber = (int)Math.ceil(list.size()/10.0) ;		//��ȡҳ������
		}
		/*�ж��Ƿ��һ�μ���*/
		if(request.getParameter("targetPage") != null) {
			targetPage = Integer.valueOf(request.getParameter("targetPage")) ;
		}
		if((targetPage - indexPage) >= 3) {
			indexPage += (targetPage%5) - 3 ;
		}
		/*Ŀ��ҳ��һ�����ݵ��±�*/
		if(targetPage >=1) {
			start = (targetPage-1)*10 ;
		}
		/*��Ŀ��ҳ�������һҳʱ��endΪtarget*��ҳ������;����end������������*/
		if(targetPage < pageNumber && targetPage > 0) {
			end = (targetPage)*10 ;
		}else if(targetPage == pageNumber) {
			end = list.size() ; 
		}
		
		request.setAttribute("indexPage", indexPage) ;
		request.setAttribute("targetPage", targetPage) ;
		request.setAttribute("pageNumber", pageNumber) ;
		request.setAttribute("list", list.subList(start, end)) ;
		request.getRequestDispatcher("main.jsp").forward(request, response) ;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
