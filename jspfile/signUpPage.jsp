<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ page import = "jsp.MemberDAO" %>
<html>
<head>
    <title>sign up</title>
    
    <script type="text/javascript">
    	var idCheck = false;
    	var identify = "";
        // �ʼ� �Է������� ���̵�, ��й�ȣ�� �ԷµǾ����� Ȯ���ϴ� �Լ�
        function checkValue()
        {
            if(!document.userInfo.id.value){
                alert("���̵� �Է��ϼ���.");
                return false;
            }
            
            if(!document.userInfo.password.value){
                alert("��й�ȣ�� �Է��ϼ���.");
                return false;
            }
            if(!document.userInfo.name.value){
                alert("�̸��� �Է��ϼ���.");
                return false;
            }
        }
        
        // ��� ��ư Ŭ���� �α��� ȭ������ �̵�
        function goLogin() {
            location.href="login.jsp";
        }
        
    </script>
    
</head>
<body>
    <div id="wrap">
        <br><br>
        <b><font size="6" color="gray">ȸ������</font></b>
        <br><br><br>
        
        <form method="post" action="signUpProcess.jsp" name="userInfo" 
                onsubmit="return checkValue()">
            <table>
                <tr>
                    <td id="title">���̵�</td>
                    <td>
                        <input type="text" name="id" id="id" maxlength="50">   
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">��й�ȣ</td>
                    <td>
                        <input type="password" name="password" maxlength="50">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�̸�</td>
                    <td>
                        <input type="text" name="name" maxlength="50">
                    </td>
                </tr>
                  
            </table>
            <br>
            <input type="submit" value="����"/>  
            <input type="button" value="���" onclick="goLogin()">
        </form>
    </div>
</body>
</html>