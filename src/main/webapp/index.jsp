<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://api-maps.yandex.ru/2.1/?apikey=36ba4524-0442-4217-b7cd-7635dfb00025&lang=ru_RU" type="text/javascript">
    </script>
    <title>Заказ пиццы</title>
</head>
<body>
<h1>Выберите пиццу:</h1>
<form action="processOrder.jsp" method="post">
    <label for="pizzaType">Тип пиццы:</label>
    <select name="pizzaType" id="pizzaType">
        <option value="Margarita">Маргарита</option>
        <option value="Four cheeses">Четыре сыра</option>
        <option value="Capriciosa">Капричоза</option>
        <option value="Hawaiian">Гавайская</option>
        <option value="Custom">Создать свою пиццу</option>
    </select>
    <br>
    <br>
    <div id="customPizza" style="display: none;">
        <label for="customPizzaName">Название вашей пиццы:</label>
        <input type="text" name="customPizzaName" id="customPizzaName"><br><br>

        <label for="customPizzaIngredients">Ингредиенты:</label>
        <textarea name="customPizzaIngredients" id="customPizzaIngredients"></textarea><br><br>
    </div>
    <label>Топпинги:</label><br>
    <input type="checkbox" name="topping" value="Olives"> Оливки<br>
    <input type="checkbox" name="topping" value="Capers"> Каперсы<br>
    <input type="checkbox" name="topping" value="Extra cheese"> Дополнительный сыр<br><br>
    <label for="customerName">Имя:</label>
    <input type="text" name="customerName" id="customerName"><br><br>
    <label for="contactPhone">Телефон:</label>
    <input type="text" name="contactPhone" id="contactPhone"><br><br>
    <label for="email">Email:</label>
    <input type="text" name="email" id="email"><br><br>
    <label for="deliveryAddress">Адрес доставки:</label>
    <input type="text" name="deliveryAddress" id="deliveryAddress" required>
    <input type="submit" value="Заказать">
</form>
<div id="map" style="width: 100%; height: 400px;"></div>
<script>
    ymaps.ready(init);
    function init() {
        var map = new ymaps.Map("map", {
            center: [54.7043897, 20.502801],
            zoom: 12
        });

        var deliveryRegion = new ymaps.Polygon([[
            [54.694813, 20.492720],
            [54.718337, 20.551591],
            [54.693313, 20.549982],
            [54.644818, 20.531981]
        ]], {
            hintContent: "Регион доставки"
        }, {
            fillColor: "#00800033",
            strokeColor: "#00800099",
            strokeWidth: 10
        });

        map.geoObjects.add(deliveryRegion);
        map.events.add('click', function (e) {
            var coords = e.get('coords');
            if (deliveryRegion.geometry.contains(coords)) {
                alert('Вы находитесь в зоне доставки!');
            } else {
                alert('Извините, доставка в вашем регионе недоступна.');
            }
        });
    }
</script>
<script type="text/javascript">
    document.getElementById("pizzaType").addEventListener("change", function () {
        var customPizzaDiv = document.getElementById("customPizza");
        if (this.value === "Custom") {
            customPizzaDiv.style.display = "block";
        } else {
            customPizzaDiv.style.display = "none";
        }
    });

</script>
</body>
</html>
