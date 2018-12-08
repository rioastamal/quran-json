#!/bin/bash
#
# Generate quran in JSON file each surah saved in one json file.
# As an example surah number 1 will be saved as:
#
# ```
# surah/1.json
# ```
#
# Usage:
# ------
# export QURAN_TEXT_DIR=path/to/quran-text
# bash generator.sh
#
# @author Rio Astamal <rio@rioastamal.net>
# @require quran-text <https://github.com/rioastamal/quran-text>

total_ayah=(7 286 200 176 120 165 206 75 129 109 123 111 43 52 \
    99 128 111 110 98 135 112 78 118 64 77 227 93 88 69 60 34 \
    30 73 54 45 83 182 88 75 85 54 53 89 59 37 35 38 29 18 45 \
    60 49 62 55 78 96 29 22 24 13 14 11 11 18 12 12 30 52 52 \
    44 28 28 20 56 40 31 50 40 46 42 29 19 36 25 22 17 19 26 \
    30 20 15 21 11 8 8 19 5 8 8 11 11 8 3 9 5 4 7 3 6 3 5 4 5 6)

surah_name_latin=("Al-Fatihah" "Al-Baqarah" "Ali 'Imran" "An-Nisa'" "Al-Ma'idah" \
    "Al-An'am" "Al-A'raf" "Al-Anfal" "At-Taubah" "Yunus" "Hud" "Yusuf" "Ar-Ra'd" \
    "Ibrahim" "Al-Hijr" "An-Nahl" "Al-Isra'" "Al-Kahf" "Maryam" "Taha" "Al-Anbiya'" \
    "Al-Hajj" "Al-Mu'minun" "An-Nur" "Al-Furqan" "Asy-Syu'ara'" "An-Naml" "Al-Qasas" \
    "Al-'Ankabut" "Ar-Rum" "Luqman" "As-Sajdah" "Al-Ahzab" "Saba'" "Fatir" "Yasin" \
    "As-Saffat" "Sad" "Az-Zumar" "Gafir" "Fussilat" "Asy-Syura" "Az-Zukhruf" \
    "Ad-Dukhan" "Al-Jasiyah" "Al-Ahqaf" "Muhammad" "Al-Fath" "Al-Hujurat" "Qaf" \
    "Az-Zariyat" "At-Tur" "An-Najm" "Al-Qamar" "Ar-Rahman" "Al-Waqi'ah" "Al-Hadid" \
    "Al-Mujadalah" "Al-Hasyr" "Al-Mumtahanah" "As-Saff" "Al-Jumu'ah" "Al-Munafiqun" \
    "At-Tagabun" "At-Talaq" "At-Tahrim" "Al-Mulk" "Al-Qalam" "Al-Haqqah" "Al-Ma'arij" \
    "Nuh" "Al-Jinn" "Al-Muzzammil" "Al-Muddassir" "Al-Qiyamah" "Al-Insan" "Al-Mursalat" \
    "An-Naba'" "An-Nazi'at" "'Abasa" "At-Takwir" "Al-Infitar" "Al-Mutaffifin" \
    "Al-Insyiqaq" "Al-Buruj" "At-Tariq" "Al-A'la" "Al-Gasyiyah" "Al-Fajr" "Al-Balad" \
    "Asy-Syams" "Al-Lail" "Ad-Duha" "Asy-Syarh" "At-Tin" "Al-'Alaq" "Al-Qadr" "Al-Bayyinah" \
    "Az-Zalzalah" "Al-'Adiyat" "Al-Qari'ah" "At-Takasur" "Al-'Asr" "Al-Humazah" "Al-Fil" \
    "Quraisy" "Al-Ma'un" "Al-Kausar" "Al-Kafirun" "An-Nasr" "Al-Lahab" "Al-Ikhlas" "Al-Falaq" "An-Nas")

surah_name_arab=("الفاتحة" "البقرة" "اٰل عمران" "النساۤء" "الماۤئدة" "الانعام" "الاعراف" \
    "الانفال" "التوبة" "يونس" "هود" "يوسف" "الرّعد" "ابرٰهيم" "الحجر" "النحل" "الاسراۤء" "الكهف" \
    "مريم" "طٰهٰ" "الانبياۤء" "الحج" "المؤمنون" "النّور" "الفرقان" "الشعراۤء" "النمل" "القصص" \
    "العنكبوت" "الرّوم" "لقمٰن" "السّجدة" "الاحزاب" "سبأ" "فاطر" "يٰسۤ" "الصّٰۤفّٰت" "ص" \
    "الزمر" "غافر" "فصّلت" "الشورى" "الزخرف" "الدخان" "الجاثية" "الاحقاف" "محمّد" "الفتح" \
    "الحجرٰت" "ق" "الذّٰريٰت" "الطور" "النجم" "القمر" "الرحمن" "الواقعة" "الحديد" "المجادلة" \
    "الحشر" "الممتحنة" "الصّفّ" "الجمعة" "المنٰفقون" "التغابن" "الطلاق" "التحريم" "الملك" \
    "القلم" "الحاۤقّة" "المعارج" "نوح" "الجن" "المزّمّل" "المدّثّر" "القيٰمة" "الانسان" \
    "المرسلٰت" "النبأ" "النّٰزعٰت" "عبس" "التكوير" "الانفطار" "المطفّفين" "الانشقاق" "البروج" \
    "الطارق" "الاعلى" "الغاشية" "الفجر" "البلد" "الشمس" "الّيل" "الضحى" "الشرح" "التين" "العلق" \
    "القدر" "البيّنة" "الزلزلة" "العٰديٰت" "القارعة" "التكاثر" "العصر" "الهمزة" "الفيل" "قريش" \
    "الماعون" "الكوثر" "الكٰفرون" "النصر" "اللهب" "الاخلاص" "الفلق" "الناس")

surah_name_trans_id=("Pembukaan" "Sapi" "Keluarga Imran" "Wanita" "Hidangan" "Binatang Ternak" \
    "Tempat Tertinggi" "Rampasan Perang" "Pengampunan" "Yunus" "Hud" "Yusuf" "Guruh" "Ibrahim" "Hijr" \
    "Lebah" "Memperjalankan Malam Hari" "Goa" "Maryam" "Taha" "Para Nabi" "Haji" "Orang-Orang Mukmin" \
    "Cahaya" "Pembeda" "Para Penyair" "Semut-semut" "Kisah-Kisah" "Laba-Laba" "Romawi" "Luqman" \
    "Sajdah" "Golongan Yang Bersekutu" "Saba'" "Maha Pencipta" "Yasin" "Barisan-Barisan" "Sad" \
    "Rombongan" "Maha Pengampun" "Yang Dijelaskan" "Musyawarah" "Perhiasan" "Kabut" "Berlutut" \
    "Bukit Pasir" "Muhammad" "Kemenangan" "Kamar-Kamar" "Qaf" "Angin yang Menerbangkan" "Bukit Tursina" \
    "Bintang" "Bulan" "Maha Pengasih" "Hari Kiamat" "Besi" "Gugatan" "Pengusiran" "Wanita Yang Diuji" \
    "Barisan" "Jumat" "Orang-Orang Munafik" "Pengungkapan Kesalahan" "Talak" "Pengharaman" "Kerajaan" \
    "Pena" "Hari Kiamat" "Tempat Naik" "Nuh" "Jin" "Orang Yang Berselimut" "Orang Yang Berkemul" \
    "Hari Kiamat" "Manusia" "Malaikat Yang Diutus" "Berita Besar" "Malaikat Yang Mencabut" \
    "Bermuka Masam" "Penggulungan" "Terbelah" "Orang-Orang Curang" "Terbelah" "Gugusan Bintang" \
    "Yang Datang Di Malam Hari" "Maha Tinggi" "Hari Kiamat" "Fajar" "Negeri" "Matahari" "Malam" \
    "Duha" "Lapang" "Buah Tin" "Segumpal Darah" "Kemuliaan" "Bukti Nyata" "Guncangan" \
    "Kuda Yang Berlari Kencang" "Hari Kiamat" "Bermegah-Megahan" "Asar" "Pengumpat" "Gajah" \
    "Quraisy" "Barang Yang Berguna" "Pemberian Yang Banyak" "Orang-Orang kafir" "Pertolongan" \
    "Api Yang Bergejolak" "Ikhlas" "Subuh" "Manusia")

lang_id=id
last_line=1
total_ayah_before=0

for surah in $( seq 1 114 )
do
    echo -n "Generating surah ${surah} - ${surah_name_latin[$surah-1]} - ${surah_name_arab[$surah-1]} ..."
    mkdir -p surah

    last_line=$(( $total_ayah_before + 1 ))

    printf \
'{
    "%s": {
        "number": "%s",
        "name": "%s",
        "name_latin": "%s",
        "number_of_ayah": "%s",
        "text": {
' "$surah" "$surah" "${surah_name_arab[$surah-1]}" "${surah_name_latin[$surah-1]}" "${total_ayah[$surah-1]}" > surah/${surah}.json

    # Generate each ayah in arabic text
    line=$last_line
    for ayah_number in $( seq 1 ${total_ayah[$surah-1]} )
    do
        arabic=$( cat $QURAN_TEXT_DIR/surah/$surah/$ayah_number.txt | sed 's/"/\\"/g' )
        comma=","

        if [ $ayah_number -eq ${total_ayah[$surah-1]} ]; then
            comma=""
        fi

        printf '            "%s": "%s"%s' "$ayah_number" "$arabic" "$comma">> surah/${surah}.json
        echo "" >> surah/${surah}.json

        line=$(( $line + 1 ))
    done

    printf '        },
        "translations": {
            "%s": {
                "name": "%s",
                "text": {
' "$lang_id" "${surah_name_trans_id[$surah-1]}" >> surah/${surah}.json

    # Generate each ayah of latin text (Bahasa Indonesia)
    line=$last_line
    for ayah_number in $( seq 1 ${total_ayah[$surah-1]} )
    do
        latin=$( cat $QURAN_TEXT_DIR/translations/id/$surah/$ayah_number.txt | sed 's/"/\\"/g' )
        comma=","

        if [ $ayah_number -eq ${total_ayah[$surah-1]} ]; then
            comma=""
        fi

        printf '                    "%s": "%s"%s' "$ayah_number" "$latin" "$comma">> surah/${surah}.json
        echo "" >> surah/${surah}.json

        line=$(( $line + 1 ))
    done

    # Closing bracket for translations
    printf '                }
            }
        },
        "tafsir": {
            "%s": {
                "kemenag": {
                    "name": "%s",
                    "source": "%s",
                    "text": {
' "$lang_id" "$( cat $QURAN_TEXT_DIR/tafsir/id/kemenag/name.txt )" "$( cat $QURAN_TEXT_DIR/tafsir/id/kemenag/source.txt )" >> surah/${surah}.json


    # Generate each ayah of tafsir (Tafsir Kemenag)
    line=$last_line
    for ayah_number in $( seq 1 ${total_ayah[$surah-1]} )
    do
        tafsir=$( cat $QURAN_TEXT_DIR/tafsir/id/kemenag/$surah/$ayah_number.txt | sed 's/"/\\"/g' )
        comma=","

        if [ $ayah_number -eq ${total_ayah[$surah-1]} ]; then
            comma=""
        fi

        printf '                        "%s": "%s"%s' "$ayah_number" "$tafsir" "$comma">> surah/${surah}.json
        echo "" >> surah/${surah}.json

        line=$(( $line + 1 ))
    done

    # Closing bracket for Tafsir Kemenag
    printf '                    }
                }
            }
        }
    }
}' >> surah/${surah}.json
    echo "done."
    total_ayah_before=$(( $total_ayah_before + ${total_ayah[$surah-1]} ))
done