INSERT INTO robots
(robot_id, name, x, y, velocity, battery, status, current_task, priority)
VALUES
('AMR_01', 'Warehouse Robot 1', 2.5, 4.0, 1.5, 92, 'IDLE', 'PICKUP_01', 1),
('AMR_02', 'Warehouse Robot 2', 8.0, 4.5, 1.2, 78, 'MOVING', 'DELIVERY_01', 2),
('AMR_03', 'Warehouse Robot 3', 5.0, 9.0, 1.0, 64, 'MOVING', 'PICKUP_02', 1);



INSERT INTO tasks
(task_id, type, pickup_x, pickup_y, destination_x, destination_y, status, robot_id)
VALUES
('TASK_001', 'PICKUP', 2, 4, 10, 8, 'ASSIGNED',
    (SELECT id FROM robots WHERE robot_id = 'AMR_01')),

('TASK_002', 'DELIVERY', 8, 4, 3, 10, 'IN_PROGRESS',
    (SELECT id FROM robots WHERE robot_id = 'AMR_02')),

('TASK_003', 'PICKUP', 5, 9, 12, 3, 'ASSIGNED',
    (SELECT id FROM robots WHERE robot_id = 'AMR_03'));
