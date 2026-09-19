const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

async function main() {

  // =========================
  // ROBOTS
  // =========================

  const robot1 = await prisma.robot.create({
    data: {
      robotId: "AMR_01",
      name: "Warehouse Robot 1",
      x: 2.5,
      y: 4.0,
      velocity: 1.5,
      battery: 92,
      status: "IDLE",
      currentTask: "PICKUP_01",
      priority: 1
    }
  });

  const robot2 = await prisma.robot.create({
    data: {
      robotId: "AMR_02",
      name: "Warehouse Robot 2",
      x: 8.0,
      y: 4.5,
      velocity: 1.2,
      battery: 78,
      status: "MOVING",
      currentTask: "DELIVERY_01",
      priority: 2
    }
  });

  const robot3 = await prisma.robot.create({
    data: {
      robotId: "AMR_03",
      name: "Warehouse Robot 3",
      x: 5.0,
      y: 9.0,
      velocity: 1.0,
      battery: 64,
      status: "MOVING",
      currentTask: "PICKUP_02",
      priority: 1
    }
  });


  // =========================
  // TASKS
  // =========================

  await prisma.task.createMany({
    data: [

      {
        taskId: "TASK_001",
        type: "PICKUP",
        pickupX: 2,
        pickupY: 4,
        destinationX: 10,
        destinationY: 8,
        status: "ASSIGNED",
        robotId: robot1.id
      },

      {
        taskId: "TASK_002",
        type: "DELIVERY",
        pickupX: 8,
        pickupY: 4,
        destinationX: 3,
        destinationY: 10,
        status: "IN_PROGRESS",
        robotId: robot2.id
      },

      {
        taskId: "TASK_003",
        type: "PICKUP",
        pickupX: 5,
        pickupY: 9,
        destinationX: 12,
        destinationY: 3,
        status: "ASSIGNED",
        robotId: robot3.id
      }

    ]
  });


  // =========================
  // ROBOT COMMUNICATION
  // =========================

  await prisma.robotMessage.create({
    data: {
      senderId: "AMR_01",
      receiverId: "AMR_02",
      messageType: "POSITION_UPDATE",
      positionX: 2.5,
      positionY: 4.0,
      velocity: 1.5,
      intent: "MOVE_FORWARD",
      priority: 1
    }
  });


  await prisma.robotMessage.create({
    data: {
      senderId: "AMR_02",
      receiverId: "AMR_01",
      messageType: "INTENT_UPDATE",
      positionX: 8.0,
      positionY: 4.5,
      velocity: 1.2,
      intent: "TURN_RIGHT",
      priority: 2
    }
  });


  // =========================
  // COLLISION EVENT
  // =========================

  await prisma.collisionEvent.create({
    data: {
      robot1Id: "AMR_01",
      robot2Id: "AMR_02",
      distance: 1.7,
      action: "AMR_01_WAIT",
      resolved: true
    }
  });


  console.log("🌱 Database seeded successfully!");

  console.log({
    robot1,
    robot2,
    robot3
  });
}


main()
  .catch((error) => {

    console.error(error);
    process.exit(1);

  })
  .finally(async () => {

    await prisma.$disconnect();

  });
