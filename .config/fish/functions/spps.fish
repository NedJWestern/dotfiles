function spps
    sudo podman ps -a --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"
end
