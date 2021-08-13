import 'package:supabase/supabase.dart';

const SUPABASE_URL = 'https://bizwsacpsxegblwxcffu.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyODc4NzI0NywiZXhwIjoxOTQ0MzYzMjQ3fQ.d8s8d9LfsOU2gCSX0P23nc9eqo2pGbC1n2fcaoGSYaQ';

final supabase = SupabaseClient(SUPABASE_URL, SUPABASE_KEY);