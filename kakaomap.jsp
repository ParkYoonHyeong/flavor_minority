<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "jsp.RestaurantDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style>
	html,
	body{
		width: 100%;
		height: 100%;
	}
</style>

<title>Insert title here</title>
</head>

<body>
	<%
		float latitude = Float.parseFloat(request.getParameter("latitude"));
		float longitude = Float.parseFloat(request.getParameter("longitude"));
		
		RestaurantDAO dao = RestaurantDAO.getInstance();
		int number = dao.findRestaurants(latitude, longitude);
		
	%>

	<div id="map" style="width:100%;height:100%;"></div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0cc283eba2401a8d3c5fd6c79744fad5"></script>
	<script type="text/javascript">
	var map
	
	var name;
	var openedWindow = null, selectedMarker = null;
	function makeMap(latitude, longitude) {
		var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(latitude, longitude), // ������ �߽���ǥ
	        level: 3 // ������ Ȯ�� ����
	    };
		map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�

		var imageSrc = 'http://the4456.iptime.org:8080/jsp/marker/Marker_Inside_Azure.png', // ��Ŀ�̹����� �ּ��Դϴ�    
	    imageSize = new kakao.maps.Size(50, 50), // ��Ŀ�̹����� ũ���Դϴ�
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // ��Ŀ�̹����� �ɼ��Դϴ�. ��Ŀ�� ��ǥ�� ��ġ��ų �̹��� �ȿ����� ��ǥ�� �����մϴ�.
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
	    var markerPosition  = new kakao.maps.LatLng(latitude, longitude);
		// ��Ŀ�� �����մϴ�
		var marker = new kakao.maps.Marker({
		    position: markerPosition,
		    image: markerImage // ��Ŀ�̹��� ���� 
		});
		
		// ��Ŀ�� ���� ���� ǥ�õǵ��� �����մϴ�
		marker.setMap(map);
		
		// ��Ŀ�� Ŭ������ �� ��Ŀ ���� ǥ���� ���������츦 �����մϴ�
		var iwContent = '<div>������ġ</div>', // ���������쿡 ǥ��� �������� HTML ���ڿ��̳� document element�� �����մϴ�
		    iwRemoveable = true; // removeable �Ӽ��� ture �� �����ϸ� ���������츦 ���� �� �ִ� x��ư�� ǥ�õ˴ϴ�

		// ���������츦 �����մϴ�
		var infowindow = new kakao.maps.InfoWindow({
		    content : iwContent,
		    removable : iwRemoveable
		});
		kakao.maps.event.addListener(marker, 'click', function() {
	        // Ŭ���� ��Ŀ�� ����, click ��Ŀ�� Ŭ���� ��Ŀ�� �ƴϸ�
	        // ��Ŀ�� �̹����� Ŭ�� �̹����� �����մϴ�
	        if (!selectedMarker || selectedMarker !== marker) {
	        	// �̹� �����ִ� infowindow�� ������ �ݴ´�.
	        	if(openedWindow){
	        		openedWindow.close();
	        	}
	            // ���� Ŭ���� ��Ŀ�� infowindow�� ����
	            infowindow.open(map, marker);
	            openedWindow = infowindow;
	        }
	        // Ŭ���� ��Ŀ�� ���� Ŭ���� ��Ŀ ��ü�� �����մϴ�
	        selectedMarker = marker;
	    });
		
		var numberOfRestaurants = <%=number%>;
		
		var i;
		<%
			int num = 0;
			for(num = 0; num< number; num++){%>
			latitude = <%=dao.getLatitude(num)%>;
			longitude = <%=dao.getLongitude(num)%>;
			name = "<%=dao.getName(num)%>";
			loadRestaurant(latitude,longitude,name);
			<%
			}
			dao.restaurants.clear();
		%>
	} 
	
	function sendMessage(msg){
		window.android.setMessage(msg);
	}
	function loadRestaurant(lati, longi, name){

		var icon = 'http://the4456.iptime.org:8080/jsp/marker/Marker_Inside_Chartreuse.png', // ��Ŀ�̹����� �ּ��Դϴ�    
		imageSize = new kakao.maps.Size(50, 50), // ��Ŀ�̹����� ũ���Դϴ�
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // ��Ŀ�̹����� �ɼ��Դϴ�. ��Ŀ�� ��ǥ�� ��ġ��ų �̹��� �ȿ����� ��ǥ�� �����մϴ�.
	    var markerImage = new kakao.maps.MarkerImage(icon, imageSize, imageOption)
	    var markerPosition  = new kakao.maps.LatLng(lati, longi);
		// ��Ŀ�� �����մϴ�
		var marker = new kakao.maps.Marker({
		    position: markerPosition,
		    image: markerImage // ��Ŀ�̹��� ���� 
		});
		// ��Ŀ�� ���� ���� ǥ�õǵ��� �����մϴ�
		marker.setMap(map);
		
		// ��Ŀ�� Ŭ������ �� ��Ŀ ���� ǥ���� ���������츦 �����մϴ�
		var iwContent = '<div>'+name+'</div>', // ���������쿡 ǥ��� �������� HTML ���ڿ��̳� document element�� �����մϴ�
		    iwRemoveable = true; // removeable �Ӽ��� ture �� �����ϸ� ���������츦 ���� �� �ִ� x��ư�� ǥ�õ˴ϴ�

		// ���������츦 �����մϴ�
		var infowindow = new kakao.maps.InfoWindow({
		    content : iwContent,
		    removable : iwRemoveable
		});
		    
		//��Ŀ�� �̺�Ʈ������
		kakao.maps.event.addListener(marker, 'click', function() {
	        // Ŭ���� ��Ŀ�� ���ų� click ��Ŀ�� Ŭ���� ��Ŀ�� �ƴϸ�
	        // ��Ŀ�� in
	        if (!selectedMarker || selectedMarker !== marker) {
	            // �̹� �����ִ� infowindow�� ������ �ݴ´�.
	        	if(openedWindow){
	        		openedWindow.close();
	        	}
	            // ���� Ŭ���� ��Ŀ�� infowindow�� ����
	            infowindow.open(map, marker);
	            openedWindow = infowindow;
	         // Ŭ���� ��Ŀ�� ���� Ŭ���� ��Ŀ ��ü�� �����մϴ�
		        selectedMarker = marker;
	        }else{
	        	var urlString = encodeURI("app://"+name);
	        	window.location.href = urlString;
	        }
	        
	    });
	}
	
	var latitude = <%=latitude%>;
	var longitude = <%=longitude%>;
	makeMap(latitude,longitude);
	
	
	</script>
	
</body>

</html>