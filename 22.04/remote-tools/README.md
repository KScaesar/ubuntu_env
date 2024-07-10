
1. **傳送 zip 檔案到遠端主機**：
   ```bash
   scp path/to/xxx.zip username@remote_host:/remote/path/
   ```
   將 `xxx.zip` 檔案傳送到遠端主機的 `/remote/path/` 路徑下，請將 `username` 和 `remote_host` 替換為你的遠端主機的使用者名稱和主機名稱或 IP 地址。

2. **解壓縮 zip 檔案並執行 `setup.sh`**：
   ```bash
   ssh username@remote_host 'unzip xxx.zip -d ./xxx && cd ./xxx && ./setup.sh'
   ```
