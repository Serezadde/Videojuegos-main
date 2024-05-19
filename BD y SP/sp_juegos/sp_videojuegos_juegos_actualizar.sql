DELIMITER $$

CREATE PROCEDURE sp_videojuegos_juegos_actualizar (
    IN id INT,
    IN nombre VARCHAR(255),
    IN descripcion VARCHAR(255),
    IN portada VARCHAR(255),
    IN precio FLOAT,
    IN idgenero INT,
    IN disponible TINYINT(1)
)
BEGIN
    UPDATE juegos
    SET nombre = nombre,
        descripcion = descripcion,
        portada = portada,
        precio = precio,
        idgenero = idgenero,
        disponible = disponible
    WHERE id = id;
END $$

DELIMITER ;
