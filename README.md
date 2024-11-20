PrivWindoze (Private Windows) is a Microsoft Windows tool, which aims to quickly delete malware, spyware, and telemetry.

Below is a list of what is currently removed:

    Microsoft Bing
    Microsoft Copilot
    Microsoft Cortana
    Microsoft Edge - X - Not removed in PrivWindoze Lite
    Microsoft Game Bar - X - Not removed in PrivWindoze Lite
    Microsoft OneDrive - X - Not removed in PrivWindoze Lite
    Microsoft Recall
    Microsoft Teams - X - Not removed in PrivWindoze Lite
    Microsoft XBox - X - Not removed in PrivWindoze Lite
    Microsoft Zune
    Acer User Experience Improvement Program
    HP Touchpoint Analytics Client
    Intel Analytics / Telemetry
    Lenovo Vantage
    Slate Digital Connect SDACollector
    Tobii Help Center / Experience

PrivWindoze also does some other nuanced things, such as clearing caches and temporary internet files that tend to pile up over time. It does not delete cookies, but it will clear caches belonging to Discord, DirectX, and Fonts. It also clears some logs from the Event Viewer, and it removes orphaned Windows Registry entries belonging to the Windows Firewall. The revocation list address cache[[8](https://www.gradenegger.eu/en/view-and-clear-the-address-cache-for-blacklists-crl-url-cache/)] is also cleared.

Additional Information:

PrivWindoze is compatible with Windows 10 and 11 and is updated daily as of November 2024. The project originates from my [GitHub](https://github.com/thisisu) and is considered [freeware](https://en.wikipedia.org/wiki/Freeware). To report issues or to suggest detections to be added, visit this [page](https://github.com/thisisu/PrivWindoze/issues).

The primary purpose of PrivWindoze is to stop and remove any nag screens[[4](https://www.elevenforum.com/t/enable-or-disable-lets-finish-setting-up-your-device-in-windows-11.5205/)], pop ups[[2](https://www.theverge.com/2023/8/30/23851902/microsoft-bing-popups-windows-11-malware)], high CPU usage issues, data collection and transmission[[5](https://www.pcmag.com/news/hp-accused-of-quietly-installing-spyware-on-windows-pcs)] -- also known as telemetry and analytics, as well as removing programs which are difficult to locate and remove or lack an 'Uninstall' button[[1](https://www.wintips.org/fix-cannot-uninstall-microsoft-edge-uninstall-is-greyed-out/)][[3](https://www.reddit.com/r/Hewlett_Packard/comments/lpxcwv/uninstall_hp_touchpoint_analytics_client/)]. Before the tool begins its scan, it will attempt to create a System Restore point. Please refer to this if there are any undesired results on your end. Or... just wait for Microsoft to send the software back to you in a couple of days via Windows Update. After the tool completes its scan, a report entitled 'PrivWindoze.txt' can be found on the User Desktop for review.

[Download PrivWindoze](https://furtivex.net/PrivWindoze.exe)

[Download PrivWindoze Lite](https://furtivex.net/PrivWindozeLite.exe)

[![donate_paypal](https://github.com/user-attachments/assets/aadd1f47-fe6a-4f61-97d4-5f30ff29fc33)](https://www.paypal.com/donate/?hosted_button_id=E68FUAQG2758N)  [![donate_amz](https://github.com/user-attachments/assets/10476e9c-92f3-4271-8410-6f38624c94b8)](https://www.amazon.com/hz/wishlist/ls/C2QC509ZM1BG?ref_=wl_share)

![image](https://github.com/user-attachments/assets/584dc9df-2f22-4865-954f-1023efc2ab90)

![image](https://github.com/user-attachments/assets/2b99a9c8-8248-480b-a131-a5101eb18683)

Windows Explorer may close during the course of the scan -- This is expected behavior

Log created on the Desktop after execution:

![privwindozelog](https://github.com/user-attachments/assets/f1a9fc24-c3af-44c4-bf3d-fd4d72c108e1)
