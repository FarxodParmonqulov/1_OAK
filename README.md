# OAK Bot — Railway Deploy Ko'rsatmasi

## 📁 Loyiha strukturasi

```
oak_bot/
├── bot.py                  ← Asosiy bot kodi
├── requirements.txt        ← Python kutubxonalari
├── Dockerfile              ← Railway uchun container
├── railway.toml            ← Railway konfiguratsiya
├── .env.example            ← Environment variables namunasi
├── .gitattributes          ← Git LFS sozlamalari
├── .gitignore              ← Git ignore
├── oak_jurnallar.docx      ← OAK jurnallar fayli
└── oak_docs/               ← Byulleten DOCX fayllar
    ├── 2016/
    │   ├── 2016-1.docx
    │   ├── 2016-2.docx
    │   └── ...
    ├── 2017/
    └── ...
```

---

## 🔧 1-QADAM: Git LFS O'rnatish

Git LFS katta fayllarni (109MB DOCX) GitHub da saqlash uchun kerak.

### Windows:
1. https://git-lfs.com/ saytiga kiring
2. "Download" tugmasini bosing
3. O'rnatgichni ishga tushiring
4. CMD yoki PowerShell oching va tekshiring:
```
git lfs version
```
`git-lfs/3.x.x` chiqsa — o'rnatildi ✅

### Mac:
```bash
brew install git-lfs
git lfs install
```

### Linux:
```bash
sudo apt-get install git-lfs
git lfs install
```

---

## 📂 2-QADAM: GitHub Repositoriya Yaratish

1. https://github.com ga kiring
2. Yuqori o'ngda **"+"** → **"New repository"** bosing
3. Repository name: `oak-bot` (yoki xohlagan nom)
4. **Private** tanlang (bot tokenini yashirish uchun)
5. **"Create repository"** bosing

---

## 💻 3-QADAM: Fayllarni GitHub ga Yuklash

**PowerShell yoki CMD da oak_bot papkasiga kiring:**

```bash
cd C:\Users\farxo\OneDrive\Ishchi stol\oak_bot
```

**Git boshlash:**
```bash
git init
git lfs install
```

**Git LFS ga DOCX fayllarni belgilash:**
```bash
git lfs track "*.docx"
git lfs track "*.db"
git add .gitattributes
```

**Barcha fayllarni qo'shish:**
```bash
git add .
git commit -m "Initial commit: OAK Bot"
```

**GitHub ga ulash (YOUR_USERNAME o'rniga sizning GitHub username):**
```bash
git remote add origin https://github.com/YOUR_USERNAME/oak-bot.git
git branch -M main
git push -u origin main
```

> ⚠️ Push paytida GitHub login/parol so'rasa:
> - Username: GitHub username ingiz
> - Password: GitHub → Settings → Developer settings → Personal access tokens → Generate new token (classic) → repo checkbox → Generate → tokenni kiriting

---

## 🚂 4-QADAM: Railway da Deploy Qilish

1. https://railway.app ga kiring
2. **"Login with GitHub"** orqali kiring
3. **"New Project"** bosing
4. **"Deploy from GitHub repo"** tanlang
5. `oak-bot` repositoriyasini tanlang
6. Railway avtomatik `Dockerfile` ni topib build qiladi

---

## ⚙️ 5-QADAM: Environment Variables Sozlash

Railway dashboardda:

1. Loyihangizni oching
2. **"Variables"** tabini bosing
3. Quyidagi o'zgaruvchilarni qo'shing:

| Variable | Qiymati |
|----------|---------|
| `BOT_TOKEN` | BotFather dan olgan tokeningiz |
| `GROUP_ID` | `-1003600714782` |
| `GROUP_INVITE` | `https://t.me/vacancy_argos_bugun` |
| `DOC_ROOT` | `/app/oak_docs` |
| `OAK_FILE` | `/app/oak_jurnallar.docx` |
| `DB_FILE` | `/app/data/oak.db` |
| `FILE_HASH_DB` | `/app/data/file_hashes.json` |
| `CHECK_INTERVAL` | `14400` |
| `ADMIN_IDS` | `146270730` |

4. **"Add"** bosing — Railway avtomatik restart qiladi

---

## 📊 6-QADAM: Ishlayotganini Tekshirish

Railway dashboardda **"Deployments"** tabini oching.

Logs da quyidagilarni ko'rishingiz kerak:
```
✅ Database tayyor
🔄 Dastlabki skanerlash boshlandi...
✅ 2016/2016-1.docx: XXX ta odam
...
✅ Bot ulandi: @your_bot_username
🤖 Polling boshlandi...
```

---

## ❓ Ko'p Uchraydigan Xatolar

### "BOT_TOKEN env variable o'rnatilmagan"
→ Railway Variables tabida `BOT_TOKEN` ni tekshiring

### "DOC_ROOT papkasi topilmadi"
→ `oak_docs/` papkasi GitHub da borligini tekshiring
→ Git LFS to'g'ri ishlayotganini tekshiring: `git lfs ls-files`

### Build xatosi
→ Railway Logs tabini oching, xato xabarini o'qing
→ `requirements.txt` da versiya muammosi bo'lishi mumkin

### Bot javob bermayapti
→ BotFather da tokenni qayta tekshiring
→ GROUP_ID to'g'riligini tekshiring

---

## 🔄 Yangi Fayllar Qo'shish

Yangi byulleten DOCX qo'shganda:
```bash
git add oak_docs/2026/2026-3.docx
git commit -m "2026-3 chorak qo'shildi"
git push
```
Railway avtomatik qayta deploy qiladi va bot yangi fayllarni skanerlaydi.

---

## 💾 Ma'lumotlar Saqlash (Muhim!)

Railway free planing da disk **ephemeral** (qayta deploy da o'chadi).

`oak.db` va `file_hashes.json` saqlanishi uchun:

**Railway Volume qo'shish:**
1. Railway dashboardda loyihani oching
2. **"+ Add Service"** → **"Volume"** tanlang
3. Mount Path: `/app/data`
4. Bu `/app/data/` papkasi qayta deploydan keyin ham saqlanadi

---

## 📞 Yordam

Muammo bo'lsa, Railway Logs ni oching va xato xabarini yuboring.
