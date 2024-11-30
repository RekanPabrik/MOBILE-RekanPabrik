import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rekanpabrik/api/loginAPI.dart';
import 'package:rekanpabrik/api/meAPI.dart';
import 'package:rekanpabrik/api/perusahaanAPI.dart';
import 'package:rekanpabrik/api/postingPekerjaanAPI.dart';
import 'package:rekanpabrik/components/companyName_input.dart';
import 'package:rekanpabrik/components/searchBarPelamarPekerjaan.dart';
import 'package:rekanpabrik/models/postingPekerjaan.dart';
import 'package:rekanpabrik/pages/HRD/changeProfilePagePerusahaan.dart';
import 'package:rekanpabrik/pages/HRD/resetPassPerusahaan.dart';
import 'package:rekanpabrik/utils/dataDummyPelamar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';

// COMPONENTS
import 'package:rekanpabrik/components/carousel.dart';
import 'package:rekanpabrik/components/confirm_pass_input.dart';
import 'package:rekanpabrik/components/containerHomePelamar.dart';
import 'package:rekanpabrik/components/email_input.dart';
import 'package:rekanpabrik/components/mydivider.dart';
import 'package:rekanpabrik/components/name_input.dart';
import 'package:rekanpabrik/components/navbarComponent.dart';
import 'package:rekanpabrik/components/pass_input.dart';
import 'package:rekanpabrik/components/searchBarCariPabrik.dart';
import 'package:rekanpabrik/components/searchBarCariPekerjaan.dart';
import 'package:rekanpabrik/components/searchBarRiwayatLamaran.dart';
import 'package:rekanpabrik/components/searchBarSavedJobs.dart';

// MODELS
import 'package:rekanpabrik/models/authService.dart';
import 'package:rekanpabrik/models/users/pelamar.dart';
import 'package:rekanpabrik/models/users/perusahaan.dart';

// THEMES
import 'package:rekanpabrik/shared/shared.dart';

// UTILS
import 'package:rekanpabrik/utils/dummyAccount.dart';
import 'package:rekanpabrik/utils/dummyMelamarPekerjaan.dart';
import 'package:rekanpabrik/utils/dummyPerusahaan.dart';
import 'package:rekanpabrik/utils/dummyPostinganPekerjaan.dart';
import 'package:rekanpabrik/utils/formattedDate.dart';

// PAGES
part 'wellcomePage.dart';

// UTILS
part 'auth/register_pelamar.dart';
part 'auth/login_page.dart';
part 'auth/register_hrd.dart';

// PELAMAR
part 'pagePelamar/home_pelamar.dart';
part 'pagePelamar/cariPabrik.dart';
part 'pagePelamar/savedJobs.dart';
part 'pagePelamar/cariPekerjaan.dart';
part 'pagePelamar/lamarPekerjaan.dart';
part 'pagePelamar/riwayatLamaran.dart';
part 'pagePelamar/detailSavedJobs.dart';
part 'pagePelamar/detailHistoryLamaran.dart';
part 'pagePelamar/profilePage.dart';
part 'pagePelamar/detailPerusahaan.dart';
part 'pagePelamar/detailPekerjaan.dart';

//HRD
part 'HRD/homepageHRD.dart';
part 'HRD/postHistory.dart';
part 'HRD/profileHRD.dart';
part 'HRD/cekpelamar.dart';
part 'HRD/postJob.dart';
part 'HRD/detailPekerjaanHRD.dart';
