# Proxmox Next VMID Configuration Utility

This script allows you to set the **starting VMID range** for automatically assigned VMIDs in **Proxmox VE 8.1 or newer**, without modifying the Perl source code.

Proxmox now supports setting the VMID range via `datacenter.cfg`.

> **⚠️ Important:**  
> Before running this script, **review its contents** to understand exactly what it will do to your system.  
> 
> Use it at your own risk. The authors are not responsible for any data loss or system issues that may result from running this script.

To run the script, use:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/liosmar123/proxmox-utils/main/set-vmid-start.sh)"
 ```

---

## 🔧 What This Script Does
``
- Prompts for a **new starting VMID** (e.g. 200)
- Updates `/etc/pve/datacenter.cfg` with:
  ```
  next-id: lower=200,upper=1000000
  ```
- Automatically creates a backup of the original file
- Displays the updated config and the next available VMID

---

Example prompt:

```bash
👉 Enter the new starting VMID (e.g. 200): 200
```

---

## 📁 Example Output in `/etc/pve/datacenter.cfg`

```ini
next-id: lower=200,upper=1000000
```

---

## 🔁 To Restore Original

Each run makes a timestamped backup like:

```
/etc/pve/datacenter.cfg.bak.2025-06-18-1204
```

You can manually restore it with:

```bash
cp /etc/pve/datacenter.cfg.bak.<timestamp> /etc/pve/datacenter.cfg
```

---

## 🛡️ Requirements

- Proxmox VE 8.1 or later
- Root privileges

---

## 💡 Tip

To test the new behavior:

```bash
pvesh get /cluster/nextid
```

It will now start assigning VMIDs from the value you configured (e.g. `200`).

---

## 📜 License

MIT – free to use and modify.
