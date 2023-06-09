<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <script src="https://kit.fontawesome.com/d4a4244bd2.js" crossorigin="anonymous"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24073e84e8ac256ed85efd18c525e7a9"></script>
    <title>Festava Live - Ticket HTML Form</title>

    <!-- CSS FILES -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@100;200;400;700&display=swap"
            rel="stylesheet"
    />

    <link href="${root}/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${root}/assets/css/bootstrap-icons.css" rel="stylesheet"/>
    <link href="${root}/assets/css/board.css" rel="stylesheet"/>
    <link href="${root}/assets/css/mac-style.css" rel="stylesheet"/>
    <link href="${root}/assets/css/write.css" rel="stylesheet"/>
    <link href="${root}/assets/css/mytrip-view.css" rel="stylesheet"/>
    <link href="${root}/assets/css/templatemo-festava-live.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://unpkg.com/flickity@2/dist/flickity.min.css"/>
</head>
<body>
<main>
    <%@ include file="/include/nav.jsp" %>
    <div class="board_background">
        <div class="board">
            <div class="window">
                <div class="titlebar">
                    <div class="buttons">
                        <div class="close">
                            <a class="closebutton" href="#"
                            ><span><strong>x</strong></span></a
                            >
                            <!-- close button link -->
                        </div>
                        <div class="minimize">
                            <a class="minimizebutton" href="#"
                            ><span><strong>&ndash;</strong></span></a
                            >
                            <!-- minimize button link -->
                        </div>
                        <div class="zoom">
                            <a class="zoombutton" href="#"
                            ><span><strong>+</strong></span></a
                            >
                            <!-- zoom button link -->
                        </div>
                    </div>
                    글 읽기
                    <!-- window title -->
                </div>
                <div class="content">
                    <div class="gallery js-flickity" data-flickity-options='{ "wrapAround": true }'>
                        <c:forEach var="dayPlace" items="${placebyDay}" varStatus="status1">
                            <div class="gallery-cell">
                                <div class="view-container">
                                    <div class="view-item">
                                        <a href="#" class="link-article">
                                            <strong class="title">Day ${status1.count}</strong>
                                        </a>
                                        <div class="board-info">
                                            <span class="date">${Date.valueOf(mytrip.startDate.toLocalDate().plusDays(status1.index))}</span>
                                        </div>
                                        <hr width="100%"/>
                                        <div class="view-content">
                                            <c:if test="${dayPlace != 0}">
                                                <div id="map${status1.index}"
                                                     style="width: 100%; height: 350px; margin-bottom: 10px"></div>
                                                <script>var markers = [];
                                                var linePath = [];
                                                var bounds = new kakao.maps.LatLngBounds(); </script>
                                                <div id="trip-list">
                                                    <c:set var="cnt" value="${0}"/>
                                                    <c:set var="center_x" value="${0}"/>
                                                    <c:set var="center_y" value="${0}"/>
                                                    <c:forEach var="place" items="${places}" varStatus="status2">
                                                        <c:if test="${place.date == Date.valueOf(mytrip.startDate.toLocalDate().plusDays(status1.index))}">
                                                            <c:set var="cnt" value="${cnt + 1}"/>
                                                            <c:set var="center_x" value="${center_x + place.x}"/>
                                                            <c:set var="center_y" value="${center_y + place.y}"/>
                                                            <script>
                                                                function addMarker(position) {
                                                                    var marker = new kakao.maps.Marker({
                                                                        position: position
                                                                    });
                                                                    markers.push(marker);
                                                                }
                                                                addMarker(new kakao.maps.LatLng(${place.y}, ${place.x}));
                                                                linePath.push(new kakao.maps.LatLng(${place.y}, ${place.x}));
                                                                bounds.extend(new kakao.maps.LatLng(${place.y}, ${place.x}));
                                                            </script>
                                                            <div class="trip-line d-flex">
                                                                <div class="index">${cnt}</div>
                                                                <div class="trip-item">
                                                                    <div class="trip-content">
                                                                        <span class="title">${place.placeName}</span>
                                                                        <div class="trip-info">
                                                                            <span class="writer">${place.category}</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                    <button type="submit" class="btn-submit"
                                                            data-no=${param.mytrip_id} data-date=${Date.valueOf(mytrip.startDate.toLocalDate().plusDays(status1.index))} >
                                                        장소 추가
                                                    </button>
                                                    <button type="submit" class="btn-remove" data-index=${status1.count}
                                                            data-no=${param.mytrip_id} data-date=${Date.valueOf(mytrip.startDate.toLocalDate().plusDays(status1.index))} >
                                                        장소 삭제
                                                    </button>
                                                </div>
                                                <script>
                                                    var mapContainer${status1.index} = document.getElementById('map${status1.index}'), // 지도를 표시할 div
                                                        mapOption${status1.index} = {
                                                            center: new kakao.maps.LatLng(${center_y/cnt}, ${center_x/cnt}), // 지도의 중심좌표
                                                            level: 3 // 지도의 확대 레벨
                                                        };
                                                    var map${status1.index} = new kakao.maps.Map(mapContainer${status1.index}, mapOption${status1.index}); // 지도를 생성합니다
                                                    for (var i = 0; i < markers.length; i++) {
                                                        markers[i].setMap(map${status1.index});
                                                    }
                                                    var polyline = new kakao.maps.Polyline({
                                                        path: linePath, // 선을 구성하는 좌표배열 입니다
                                                        strokeWeight: 5, // 선의 두께 입니다
                                                        strokeColor: '#000000', // 선의 색깔입니다
                                                        strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                                                        strokeStyle: 'dashed' // 선의 스타일입니다
                                                    });
                                                    polyline.setMap(map${status1.index});
                                                    map${status1.index}.setBounds(bounds);
                                                </script>
                                            </c:if>
                                            <c:if test="${dayPlace == 0}">
                                                <div style="height:100%; font-weight:200; text-align:center; line-height:100%">
                                                    게시글이 존재하지 않습니다.
                                                </div>
                                                <button type="submit" class="btn-submit"
                                                        data-no=${param.mytrip_id} data-date=${Date.valueOf(mytrip.startDate.toLocalDate().plusDays(status1.index))} >
                                                    장소 추가
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <!-- window content -->
    </div>
    </div>
    </div>
    </div>
</main>
<%@ include file="/include/footer.jsp" %>
</body>
<script src="https://unpkg.com/flickity@2/dist/flickity.pkgd.min.js"></script>
<script>
    let btns = document.querySelectorAll(".btn-submit");
    btns.forEach(function (btn) {
        btn.addEventListener("click", function () {
            location.href = "${root}/mytrip?action=mvadd&mytrip_id=" + this.getAttribute("data-no") + "&date=" + this.getAttribute("data-date");
        });
    });
    let removes = document.querySelectorAll(".btn-remove");
    removes.forEach(function (removebtn) {
        removebtn.addEventListener("click", function () {
            location.href = "${root}/mytrip?action=mvremove&mytrip_id=" + this.getAttribute("data-no") + "&date=" + this.getAttribute("data-date") + "&index=" + this.getAttribute("data-index");
        });
    });
</script>
</html>
