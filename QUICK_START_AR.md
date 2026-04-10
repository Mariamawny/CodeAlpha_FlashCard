# 🚀 Quick Start Guide - VS Code

## الخطوات السريعة للبدء

### 1️⃣ فتح المشروع في VS Code
```bash
# افتح مجلد المشروع
code flashcard_app
```

### 2️⃣ تثبيت الحزم
```bash
# اضغط Ctrl+` لفتح Terminal في VS Code
# أو اذهب إلى Terminal > New Terminal

flutter pub get
```

### 3️⃣ تشغيل التطبيق
```bash
# على محاكي أو جهاز فعلي
flutter run

# أو استخدم الاختصار:
# F5 (إذا كان لديك launch configuration)
```

### 4️⃣ اختر جهاز التشغيل
```
Available devices:
1. Chrome
2. Android Emulator
3. iPhone Simulator
4. وغيرها...
```

---

## ⌨️ اختصارات VS Code المفيدة

| الاختصار | الوظيفة |
|---------|--------|
| `Ctrl+K Ctrl+C` | التعليق |
| `Ctrl+/` | تبديل التعليق |
| `Alt+Shift+F` | تنسيق الكود |
| `Ctrl+Shift+D` | اللغة الإنجليزية (تصحيح الأخطاء) |
| `F5` | ابدأ التصحيح |
| `Ctrl+F5` | إعادة تشغيل التطبيق |

---

## 📦 الملفات الرئيسية

```
flashcard_app/
├── lib/
│   └── main.dart                    ← الملف الرئيسي للتطبيق
├── pubspec.yaml                     ← إدارة الحزم والإعدادات
├── .vscode/
│   ├── launch.json                 ← إعدادات التصحيح
│   └── settings.json               ← إعدادات المحرر
├── README.md                        ← الوثائق الكاملة
├── CHANGELOG.md                     ← سجل التغييرات
└── analysis_options.yaml            ← قواعد التحليل
```

---

## 🔧 تكوين Flutter SDK

إذا لم يتعرف VS Code على Flutter:

1. اضغط `Ctrl+Shift+P`
2. ابحث عن `Dart: Set Dart SDK Location`
3. حدد مسار Dart SDK

أو في `settings.json`:
```json
{
  "dart.flutterSdkPath": "/path/to/flutter"
}
```

---

## 🐛 حل المشاكل الشائعة

### ❌ الأمر `flutter` غير معروف
```bash
# إضف Flutter إلى PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### ❌ لا توجد أجهزة متاحة
```bash
# قائمة الأجهزة المتاحة
flutter devices

# شغل محاكي Android
emulator -avd emulator_name

# أو استخدم Chrome
flutter run -d chrome
```

### ❌ أخطاء في الحزم
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📱 اختبار على أجهزة مختلفة

```bash
# على محاكي Chrome
flutter run -d chrome

# على محاكي iOS
flutter run -d iphone

# على محاكي Android محدد
flutter run -d emulator-5554

# مع وضع التطوير
flutter run --debug

# مع وضع الإصدار (أسرع)
flutter run --release

# مع وضع الملف الشخصي
flutter run --profile
```

---

## 🎯 نصائح للتطوير

### Hot Reload (مهم جداً!)
- أثناء التطبيق يعمل، اضغط `R` لإعادة تحميل فوري
- أو اضغط `Ctrl+\` في VS Code
- **لا تفقد حالة التطبيق!**

### Hot Restart
- اضغط `Shift+R` لإعادة تشغيل كاملة
- **ينسى حالة التطبيق**

### التصحيح (Debugging)
- F5: بدء التصحيح
- Ctrl+F5: إعادة التصحيح
- ضع نقاط توقف (Breakpoints) بالنقر على اليسار

---

## 📚 موارد مفيدة

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow - Flutter Tag](https://stackoverflow.com/questions/tagged/flutter)

---

## ✅ التحقق من الإعداد

```bash
# تحقق من أن كل شيء يعمل
flutter doctor

# يجب أن ترى:
# ✓ Flutter (Channel stable)
# ✓ Android toolchain
# ✓ Xcode (للـ iOS)
# ✓ VS Code
```

---

**اللآن أنت جاهز للتطوير! 🎉**

استمتع بتطوير تطبيقك الأول مع Flutter!
