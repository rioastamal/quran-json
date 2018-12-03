## Tentang

Alhamdulillah puji syukur ke hadirat Allah SWT. Sholawat serta salam semoga selalu tercurahkan kepada Nabi Muhammad SAW.

Quran-json adalah project untuk menyajikan kitab suci Al-Quran dalam bentuk file json surah per surah. Dimana satu surah diwakili oleh satu buah file json. Sebagai contoh surah pertama (Al-Fatihah) lokasi penyimpanannya adalah `surah/1.json`. Total surah (file json) yang ada adalah 114 file.

Al-Quran adalah kitab suci sempurna yang diturunkan Allah SWT. segala bentuk kesalahan yang ada pada project ini adalah pasti karena kebodohan dan kekhilafan saya sendiri. Untuk itu mohon dengan hormat jika anda menemukan ada suatu kesalahan untuk menghubungi saya melalui email.

Project Al-Quran lain:

- [quran-web](https://github.com/rioastamal/quran-web)
- [quran-text](https://github.com/rioastamal/quran-text)
- [quran-single-file](https://github.com/rioastamal/quran-single-file)

## Latar Belakang

Latar belakang kenapa saya membuat project ini adalah karena pada handphone  saya yaitu Blackberry Passport (SE) tidak ada aplikasi atau mobile website Quran yang dapat berjalan dengan baik di perangkat saya tersebut.

Kebanyakan mobile site tersebut menggunakan terlalu banyak javascript sehingga lambat atau kadang tampilannya tidak sesuai dengan yang saya inginkan. Sehingga saya berinisiatif untuk membuat situs mobile Quran static yang ringan dan juga mudah digunakan. Tentunya sesuai selera saya karena untuk saya gunakan pribadi.

Dalam proses pembuatan itulah saya melakukan pengumpulan ayat-ayat dalam bentuk file text agar dapat diproses oleh generator. Generator tersebut akan menghasilkan sebuah situs mobile static Quran.

## Sumber

Sumber utama ayat-ayat Al-Quran dan terjemahannya dalam project ini didapat dari situs dan aplikasi resmi dari Kementrian Agama Republik Indonesia yang dapat diakses di https://quran.kemenag.go.id.

## Generator

File yang ada di folder surah/ dihasilkan oleh Bash script `generator.sh`. Script ini memerlukan file quran dan terjemahan yang ada pada project [quran-text](https://github.com/rioastamal/quran-text).

Cara menjalankan script.

```
$ QURAN_TEXT_DIR=/path/to/quran-text bash generator.sh
Generating surah 1 - Al-Fatihah - الفاتحة ...done.
Generating surah 2 - Al-Baqarah - البقرة ...done.
Generating surah 3 - Ali 'Imran - اٰل عمران ...done.
Generating surah 4 - An-Nisa' - النساۤء ...done.
Generating surah 5 - Al-Ma'idah - الماۤئدة ...done.
...
dst
...
```

## Penulis

Project ini dibuat oleh Rio Astamal \<rio@rioastamal.net\>.

## Kontribusi

Jika anda ingin melakukan kontribusi pada project ini silahkan lakukan Pull Request [PR] melalui Github.