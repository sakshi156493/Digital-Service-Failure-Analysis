create database digital_service_analysis;
use digital_service_analysis;
create table services (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(100),
    team_name VARCHAR(100)
);
insert into services VALUES
(1, 'Authentication Service', 'Security Team'),
(2, 'Payment Service', 'Finance Team'),
(3, 'Order Service', 'Order Team'),
(4, 'Notification Service', 'Messaging Team');
select * from services;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO users VALUES
(101, 'Amit', 'Mumbai'),
(102, 'Riya', 'Pune'),
(103, 'Karan', 'Delhi'),
(104, 'Sneha', 'Bangalore'),
(105, 'Rahul', 'Hyderabad');

select * from users;

CREATE TABLE service_logs (
    log_id INT PRIMARY KEY,
    service_id INT,
    user_id INT,
    event_type VARCHAR(50),
    status VARCHAR(20),
    failure_reason VARCHAR(100),
    event_time DATETIME,
    FOREIGN KEY (service_id) REFERENCES services(service_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
INSERT INTO service_logs VALUES
(1, 1, 101, 'LOGIN', 'SUCCESS', NULL, '2024-11-20 09:05:00'),
(2, 1, 102, 'LOGIN', 'FAILURE', 'INVALID_PASSWORD', '2024-11-20 09:07:00'),
(3, 2, 102, 'PAYMENT', 'FAILURE', 'INSUFFICIENT_BALANCE', '2024-11-20 09:10:00'),
(4, 2, 103, 'PAYMENT', 'SUCCESS', NULL, '2024-11-20 09:12:00'),
(5, 3, 104, 'ORDER_CREATE', 'SUCCESS', NULL, '2024-11-20 09:15:00'),
(6, 3, 105, 'ORDER_CREATE', 'FAILURE', 'SERVICE_TIMEOUT', '2024-11-20 19:30:00'),
(7, 2, 105, 'PAYMENT', 'FAILURE', 'GATEWAY_ERROR', '2024-11-20 19:32:00'),
(8, 1, 103, 'LOGIN', 'FAILURE', 'ACCOUNT_LOCKED', '2024-11-21 10:00:00'),
(9, 4, 104, 'SEND_NOTIFICATION', 'SUCCESS', NULL, '2024-11-21 10:05:00'),
(10, 4, 105, 'SEND_NOTIFICATION', 'FAILURE', 'SERVER_DOWN', '2024-11-21 10:10:00');
select * from service_logs;
CREATE TABLE incidents (
    incident_id INT PRIMARY KEY,
    service_id INT,
    start_time DATETIME,
    end_time DATETIME,
    reason VARCHAR(100),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

INSERT INTO incidents VALUES
(201, 2, '2024-11-20 19:25:00', '2024-11-20 20:00:00', 'Payment Gateway Issue'),
(202, 3, '2024-11-20 19:20:00', '2024-11-20 19:50:00', 'Order Service Timeout'),
(203, 4, '2024-11-21 10:00:00', '2024-11-21 10:30:00', 'Notification Server Down');
select * from incidents;


CREATE TABLE incident_users (
    incident_id INT,
    user_id INT,
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
INSERT INTO incident_users VALUES
(201, 102),
(201, 105),
(202, 105),
(203, 104),
(203, 105);

#insight 1 failure count by service 
SELECT s.service_name,
       COUNT(*) AS failure_count
FROM service_logs l
JOIN services s ON l.service_id = s.service_id
WHERE l.status = 'FAILURE'
GROUP BY s.service_name
ORDER BY failure_count DESC;

#insight 2 failure count by team name 
SELECT s.team_name,
       COUNT(*) AS total_failures
FROM service_logs l
JOIN services s ON l.service_id = s.service_id
WHERE l.status = 'FAILURE'
GROUP BY s.team_name;

#insight 3 peak failure hours
SELECT 
    CASE 
        WHEN HOUR(event_time) = 0 THEN 12
        WHEN HOUR(event_time) > 12 THEN HOUR(event_time) - 12
        ELSE HOUR(event_time)
    END AS hour_12,
    CASE 
        WHEN HOUR(event_time) < 12 THEN 'AM'
        ELSE 'PM'
    END AS period,
    COUNT(*) AS failures
FROM service_logs
WHERE status = 'FAILURE'
GROUP BY hour_12, period
ORDER BY failures DESC;

#insight 4 downtime
SELECT 
    i.incident_id,
    i.reason AS incident_name,
    s.service_name,
    TIMESTAMPDIFF(MINUTE, i.start_time, i.end_time) AS downtime_minutes
FROM incidents i
JOIN services s ON i.service_id = s.service_id
ORDER BY downtime_minutes DESC;

#insight 5  comarison failure count and success count 
SELECT status,
       COUNT(*) AS total_events
FROM service_logs
GROUP BY status;

#insight 6 failures by uses city
SELECT u.city,
       COUNT(*) AS failures
FROM service_logs l
JOIN users u ON l.user_id = u.user_id
WHERE l.status = 'FAILURE'
GROUP BY u.city;

select service_id, count(*) 








