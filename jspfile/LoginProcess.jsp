<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "jsp.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login process</title>
</head>
<body>
	<%
        // ���ڵ� ó��
        request.setCharacterEncoding("euc-kr"); 
        
        // �α��� ȭ�鿡 �Էµ� ���̵�� ��й�ȣ�� �����´�
        String id= request.getParameter("id");
        String pw = request.getParameter("password");
        
        // DB���� ���̵�, ��й�ȣ Ȯ��
        MemberDAO dao = MemberDAO.getInstance();
        int check = dao.loginCheck(id, pw);
        
        // URL �� �α��ΰ��� ���� �޽���
        String msg = "";
        
        if(check == 1)    // �α��� ����
        { 
            msg = "app://"+id;
        }
        else if(check == 0) // ��й�ȣ�� Ʋ�����
        {
            msg = "login.jsp?msg=0";
        }
        else    // ���̵� Ʋ�����
        {
            msg = "login.jsp?msg=-1";
        }
         
      
        response.sendRedirect(msg);
    %>
</body>
</html>