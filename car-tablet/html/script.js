window.addEventListener("message", function (event) {
    if (event.data.action === "open") {
        document.getElementById("tablet").style.display = "block";
    }

    if (event.data.action === "close") {
        document.getElementById("tablet").style.display = "none";
    }

    if (event.data.action === "loadVehicles") {
        const list = document.getElementById("vehicle-list");
        list.innerHTML = "";

        event.data.vehicles.forEach(v => {
            const div = document.createElement("div");
            div.className = "vehicle";
            div.innerText = v.label;
            div.onclick = () => spawnVehicle(v.model);
            list.appendChild(div);
        });
    }
});

function spawnVehicle(model) {
    fetch(`https://${GetParentResourceName()}/spawnVehicle`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ model })
    });
}

function closeTablet() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: "POST"
    });
}