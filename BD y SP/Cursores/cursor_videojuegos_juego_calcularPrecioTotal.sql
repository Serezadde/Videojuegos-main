DELIMITER //

CREATE PROCEDURE cursor_videojuegos_juego_calcularPrecioTotal()
BEGIN
    DECLARE total FLOAT;
    DECLARE contador INT DEFAULT 0;
    DECLARE id_juego INT;
    DECLARE precio_juego FLOAT;

    DECLARE cur CURSOR FOR
        SELECT id, precio FROM juegos LIMIT 10;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET contador = 10;

    SET total = 0;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO id_juego, precio_juego;
        IF contador = 10 THEN
            LEAVE read_loop;
        END IF;
        SET total = total + precio_juego;
        SET contador = contador + 1;
    END LOOP;

    CLOSE cur;

    SELECT total AS precio_total;
END //

DELIMITER ;