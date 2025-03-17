-- TODO: Esta consulta devolverá una tabla con los ingresos por mes y año.
-- Tendrá varias columnas: month_no, con los números de mes del 01 al 12;
-- month, con las primeras 3 letras de cada mes (ej. Ene, Feb);
-- Year2016, con los ingresos por mes de 2016 (0.00 si no existe);
-- Year2017, con los ingresos por mes de 2017 (0.00 si no existe); y
-- Year2018, con los ingresos por mes de 2018 (0.00 si no existe).
SELECT 
    strftime('%m', oo.order_purchase_timestamp) AS month_no,
    CASE 
        WHEN strftime('%m', oo.order_purchase_timestamp) = '01' THEN 'Jan'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '02' THEN 'Feb'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '03' THEN 'Mar'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '04' THEN 'Apr'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '05' THEN 'May'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '06' THEN 'Jun'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '07' THEN 'Jul'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '08' THEN 'Aug'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '09' THEN 'Sep'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '10' THEN 'Oct'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '11' THEN 'Nov'
        WHEN strftime('%m', oo.order_purchase_timestamp) = '12' THEN 'Dec'
    END AS month,

    COALESCE(SUM(CASE WHEN strftime('%Y', oo.order_purchase_timestamp) = '2016' 
                      THEN oi.price + oi.freight_value 
                 END), 0.00) AS Year2016,

    COALESCE(SUM(CASE WHEN strftime('%Y', oo.order_purchase_timestamp) = '2017' 
                      THEN oi.price + oi.freight_value 
                 END), 0.00) AS Year2017,

    COALESCE(SUM(CASE WHEN strftime('%Y', oo.order_purchase_timestamp) = '2018' 
                      THEN oi.price + oi.freight_value 
                 END), 0.00) AS Year2018

FROM olist_orders oo
JOIN olist_order_items oi ON oo.order_id = oi.order_id
WHERE oo.order_status = 'delivered'
GROUP BY strftime('%y-%m', oo.order_purchase_timestamp)
ORDER BY month_no;
