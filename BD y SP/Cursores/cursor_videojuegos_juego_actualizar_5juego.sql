DELIMITER $$

CREATE PROCEDURE insertar_actualizar_juegos()
BEGIN
    DECLARE contador INT DEFAULT 0;
    DECLARE id_juego INT;
    DECLARE nombre_juego VARCHAR(255);
    DECLARE descripcion_juego VARCHAR(255);
    DECLARE portada_juego VARCHAR(255);
    DECLARE precio_juego FLOAT;
    DECLARE id_genero_juego INT;
    DECLARE disponible_juego TINYINT;

    -- Cursor para seleccionar los juegos
    DECLARE juegos_cursor CURSOR FOR
        SELECT id, nombre, descripcion, portada, precio, idgenero, disponible FROM juegos LIMIT 5;

    -- Handler para el final del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET contador = 5;

    OPEN juegos_cursor;

    read_loop: LOOP
        FETCH juegos_cursor INTO id_juego, nombre_juego, descripcion_juego, portada_juego, precio_juego, id_genero_juego, disponible_juego;
        
        -- Si no hay más filas, sal del bucle
        IF contador = 5 THEN
            LEAVE read_loop;
        END IF;

        -- Insertar o actualizar el juego dependiendo de si ya existe o no
        IF EXISTS (SELECT 1 FROM juegos WHERE id = id_juego) THEN
            -- Actualizar juego existente
            UPDATE juegos 
            SET nombre = nombre_juego, 
                descripcion = descripcion_juego, 
                portada = portada_juego, 
                precio = precio_juego, 
                idgenero = id_genero_juego, 
                disponible = disponible_juego
            WHERE id = id_juego;
        ELSE
            -- Insertar nuevo juego
            INSERT INTO juegos (id, nombre, descripcion, portada, precio, idgenero, disponible) 
            VALUES (id_juego, nombre_juego, descripcion_juego, portada_juego, precio_juego, id_genero_juego, disponible_juego);
        END IF;

        -- Incrementar el contador
        SET contador = contador + 1;
    END LOOP;

    CLOSE juegos_cursor;
END$$

DELIMITER ;
