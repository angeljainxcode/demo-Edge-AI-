import mermaid from "mermaid";

mermaid.initialize({
    startOnLoad: true,
    theme: "default"
});

const schema = `
flowchart TD

    A[AMR 1] 
    B[AMR 2]
    C[AMR 3]

    A1[Sensors]
    B1[Sensors]
    C1[Sensors]

    A2[Edge AI]
    B2[Edge AI]
    C2[Edge AI]

    P2P[Decentralized P2P Communication]

    CP[Collision Prediction]

    CR[Conflict Resolution]

    DA[Distributed Task Allocation]

    RP[Dynamic Re-routing]

    PP[Local Path Planning]

    M[Motor Controller]

    D[Live Fleet Dashboard]

    A --> A1
    B --> B1
    C --> C1

    A1 --> A2
    B1 --> B2
    C1 --> C2

    A2 <--> P2P
    B2 <--> P2P
    C2 <--> P2P

    P2P --> CP
    CP --> CR

    CR --> DA
    DA --> RP
    RP --> PP

    PP --> M

    A2 --> D
    B2 --> D
    C2 --> D

    D -. Monitoring .-> P2P
`;

document.addEventListener("DOMContentLoaded", async () => {

    const container = document.getElementById("schema");

    container.innerHTML = `
        <div class="mermaid">
            ${schema}
        </div>
    `;

    await mermaid.run();
});
