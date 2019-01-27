program kasir_supermarket;
uses crt;

type datamasukkan = record
	 nama:string;
	 tgl:Integer;
	 bulan:string;
	 tahun:integer;
	 jenis_member:string;
	 jumlahawal:real;
	 jumlahtransaksi:real;
	 total:real;
end;
   
     type id_struk = array[0..6] of datamasukkan;


var
	total,diskon_akhirbulan,diskonmember,diskon,jumlahsetdiskon,totalbulanan:real;
	n,cek_harimax,nmax,terisi,cek_nilaikosong,i,a:integer;
	cektahun:Boolean;
	menu,pilihan:char;
	data:id_struk;
	katakunci:string;
	
//===============================================================================================================================================================================================================================
function cek_member(data:id_struk): real;
begin
  case data[i].jenis_member of

  'gold','GOLD' : cek_member:=0.5;
  
  'silver','SILVER' : cek_member:=0.2;

  'platinum','PLATINUM' : cek_member:=0.1;

  'nomember','NONMEMBER' : cek_member:=0;

  else
  cek_member:=0;

  end;
end;

function cektahunkabisat(data:id_struk): Boolean;
begin
	cektahunkabisat:=false;
	if (data[i].tahun mod 400 = 0) or (data[i].tahun mod 4 = 0) then
	cektahunkabisat:=true

	else
	cektahunkabisat:=False;
	
end;

function harimax(data:id_struk): Integer;
var
	a:Boolean;
begin
	a:=cektahunkabisat(data);

	case data[i].bulan of
		'1': harimax:=31;
		'2': begin
		                if a = true then 
		                harimax:=29

		                else if a = false then
		                harimax:=28;   
		                end;

		'3': harimax:=31;
		'4': harimax:=31;
		'5': harimax:=30;
		'6':harimax:=31;
		'7':harimax:=30;
		'8':harimax:=31;
		'9':harimax:=30;
		'10':harimax:=31;
		'11':harimax:=30;
		'12':harimax:=31;
    else
    harimax:=32;
		
	end;
	
end;

function diskonakhirbulan(data:id_struk):Real;
var
	a:Integer;
begin

if (data[i].tgl = harimax(data)) and (data[i].total >= 1000000) then
	diskonakhirbulan:=0.5

else
	diskonakhirbulan:=0;
	
end;

function cekbulan(data:id_struk): Boolean;
begin
	case data[i].bulan of

	    '1':cekbulan:=true;
		'2':cekbulan:=true;
		'3':cekbulan:=true;
		'4':cekbulan:=true;
		'5':cekbulan:=true;
		'6':cekbulan:=true;
		'7':cekbulan:=true;
		'8':cekbulan:=true;
		'9':cekbulan:=true;
		'10':cekbulan:=true;
		'11':cekbulan:=true;
		'12':cekbulan:=true;

	else
     cekbulan:=False;
	
    end;
end;

function searchkosong(data:id_struk; nmax:integer): Integer;
var
	nilai:Integer;

begin
i:=1;
nilai:=data[i].tgl;
repeat
        if nilai = 0 then
        searchkosong:=i
        
        else
        searchkosong:=0;
   i:=i+1;
	until i=nmax;	
end;

function caridata(nmax:Integer; h:integer): Integer;
begin
i:=1;
	while(i<=nmax) do
	begin
	if i = h then
	caridata:=h

	else if (i>nmax)  and (i <> h) then
	caridata:=0;
    i:=i+1;
    end;
end;

function carinama(data:id_struk; nama_user:string): Boolean;
var
	k: Integer;
begin
	k:=1;
	while (k<n) do
	begin
	if nama_user = data[k].nama then
	begin
	carinama:=true;
	end

     else
	 carinama:=false;
	 

	 k:=k+1;	
	end;
	
end;

function caritotal(data:id_struk; nama_user:string): real;
var
	k: Integer;
begin
	k:=1;
	while (k<n) do
	begin
	if nama_user = data[k].nama then
	begin
	caritotal:=data[k].total;
	end

     else
	 caritotal:=0;
	 

	 k:=k+1;	
	end;
	
end;

//==============================================================================================================================================================================

procedure hitungdiskon_dan_jumlahsetelahdiskon(var data:id_struk);
	var
		nilaimember:real;
		nilai_diskon_akhirbulan:real;
begin
	nilaimember:=cek_member(data);
	nilai_diskon_akhirbulan:=diskonakhirbulan(data);

	diskon:=(data[i].total*cek_member(data))+(data[i].total*diskonakhirbulan(data));
	total:=data[i].total-diskon;

writeln('diskon yg anda dapatkan bulan ini: ',diskon:4:2);
writeln('total belanjaan anda setelah diskon: ',total:4:2);
end;


procedure inputdatakonsumen( var data:id_struk);

var
	perintah:char;
	cekhari:integer;
	inputanbulan,ceknama:Boolean;
	carinilaikosong:integer;
begin
	clrscr;
i:=n;
while (i <= nmax)  and (perintah <> 'n') do
begin
if (n >= nmax)  then
begin
	    

if searchkosong(data,nmax) <> 0 then
	begin
repeat
data[i].total:=0;
data[i].jumlahtransaksi:=0;
write('masukkan nama: '); readln(data[i].nama);
	write('masukkan tahun belanja: '); readln(data[i].tahun);
repeat
	begin
	write('masukkan bulan belanja: '); readln(data[i].bulan);
	inputanbulan:=cekbulan(data);
if inputanbulan = false then
	writeln('bulan yg anda masukkan salah cobaa lagi');
	end;
until (inputanbulan = true);
repeat
	begin
	write('masukkan tgl belanja: '); readln(data[i].tgl);
	harimax(data);
	writeln;
if data[i].tgl > (harimax(data)) then
	write('inputan anda salah periksa kembali');
	end;
until data[i].tgl <= (harimax(data));
	write('masukkan jenis member(gold/silver/platinum/nomember): '); readln(data[i].jenis_member);
	carinama(data,data[i].nama);
	if (carinama(data,data[i].nama) = true) and (n>1) then
	begin
	write('masukkan jumlah belanja: '); readln(data[i].jumlahtransaksi);	
	data[i].total:=data[i].total+data[i].jumlahtransaksi;
	end
	else
	begin
	write('masukkan jumlah awal belanja: '); readln(data[i].jumlahawal);
	data[i].total:=data[i].total+data[i].jumlahawal;
	data[i].jumlahtransaksi:=data[i].jumlahtransaksi+data[i].jumlahawal;
	end;
    i:=i+1;
    write('ingin input lagi?'); readln(perintah);
    until(perintah = 'n');
	    end
else if searchkosong(data,nmax) <= 0 then
	begin
	repeat
	write('maaaf data sudah penuh');
	write('ingin selesai?(tekan n unutk selesai)'); readln(perintah);
	until(perintah = 'n');
end
end
else
begin
  writeln('data yg terisi saat ini,',n);
  writeln;
  writeln;
begin
    n:=n+1;
    i:=n;
   repeat 
   data[i].total:=0;
   data[i].jumlahtransaksi:=0;
   write('masukkan nama: '); readln(data[i].nama);
	write('masukkan tahun belanja: '); readln(data[i].tahun);
	repeat
begin
	write('masukkan bulan belanja: '); readln(data[i].bulan);
	inputanbulan:=cekbulan(data);
	if inputanbulan = false then
	writeln('bulan yg anda masukkan salah cobaa lagi');
end;
	until (inputanbulan = true);
	repeat
begin
	write('masukkan tgl belanja: '); readln(data[i].tgl);
	writeln;
	if data[i].tgl > (harimax(data)) then
	write('inputan anda salah periksa kembali');
end;
until data[i].tgl <= (harimax(data));
	write('masukkan jenis member(gold/silver/platinum): '); readln(data[i].jenis_member);
	carinama(data,data[i].nama);
	if (carinama(data,data[i].nama) = true) and (n>1) then
	begin
	write('masukkan jumlah belanja: '); readln(data[i].jumlahtransaksi);
	data[i].total:=caritotal(data,data[i].nama);	
	data[i].total:=data[i].total+data[i].jumlahtransaksi;
	end
	else
	begin
	write('masukkan jumlah awal belanja: '); readln(data[i].jumlahawal);
	data[i].total:=data[i].total+data[i].jumlahawal;
	data[i].jumlahtransaksi:=data[i].jumlahtransaksi+data[i].jumlahawal;
	end;
    write('ingin inpuut ulaang atau tidak?(tekan y untuk iyaa dan tekan n untuk tidak:  '); readln(perintah);
until(perintah = 'n');
end;
i:=i+1;
end;
end;
end;

procedure showdatakonsumen( var data:id_struk);
var
	perintah: char;
	k:Integer;
begin	
repeat
clrscr;
i:=1;
	while (i<=nmax) do
	begin
	if data[i].tahun = 0 then
	 begin
	 write(' ');
	 i:=i+1;
	 end
	else
	begin
	 writeln('id: ',i);
	 writeln('nama: ',data[i].nama);
     writeln('tahun belanja: ',data[i].tahun);
     writeln('bulan belanja: ',data[i].bulan);
     writeln('tanggal belanja: ',data[i].tgl);
     writeln('jenis member belanja: ',data[i].jenis_member);
     writeln('jumlah belanja: ',data[i].jumlahtransaksi:4:2);
     writeln('total belanja: ',data[i].total:4:2);
     writeln;
     writeln;
     i:=i+1;
     end;
	 end;
write('ulangi show data dengan tekan sembarang dan tekan n unutk kembali ke menu'); readln(perintah);
until perintah = 'n';
writeln;
writeln;
end;

procedure editdata(var data:id_struk);
	var
		nilai:Integer;
		nilaicari:Integer;
		pilihan:char;
begin
	clrscr;
	writeln('data yang ada saat ini: ',n);
	write('masukan id data yg ingin di edit: '); readln(nilai);
	nilaicari:=caridata(nmax,nilai);
 if (nilaicari <= nmax) and (nilaicari > 0) then
	begin
	writeln('edit semua data atau data tertentu?');
		writeln('s=semua');
		writeln('g=tgl');
		writeln('b=bulan');
		writeln('t=tahun');
		writeln('m=jenis member');
		writeln('h=nama user'); 
		writeln('dan tekan(selain tombol tadi utk kembali ke menu) untuk keluar:   '); readln(pilihan);
	 case pilihan of
	  		's': begin
                 write('masukkan tahun pengganti: ');           readln(data[nilaicari].tahun);
                 write('masukkan bulan pengganti: ');           readln(data[nilaicari].bulan);
                 write('masukkan tgl pengganti: ');             readln(data[nilaicari].tgl);
                 write('masukkan jenis member pengganti: ');    readln(data[nilaicari].jenis_member);
                 write('masukkan nama pengganti: ');            readln(data[nilaicari].nama);
	  		     end;

	  		'g':begin write('masukkan tgl pengganti: ');             readln(data[nilaicari].tgl);             end;
            'b':begin write('masukkan bulan pengganti: ');           readln(data[nilaicari].bulan);           end;
            't':begin write('masukkan tahun pengganti: ');           readln(data[nilaicari].tahun);           end;
            'm':begin write('masukkan jenis member pengganti: ');    readln(data[nilaicari].jenis_member);    end;
            'h':begin write('masukkan nama pengganti: ');            readln(data[nilaicari].nama);            end;

            else
	  	end;
	  end
else 
write('data tidak ditemukan');
writeln;
writeln; 	
end;

procedure deletedata(var data:id_struk);
	var
	nilaicari:Integer;
	nilai:Integer;
	pilihan:char;
begin
	clrscr;
	write('masukan id data yg ingin di hapus: '); readln(nilai);
	writeln('data yang ada saat ini: ',n);
	nilaicari:=caridata(nmax,nilai);


    if (nilaicari <= nmax) and (nilaicari > 0) then
	begin
	writeln('delete semua data atau data tertentu?');
		writeln('s=semua');
		writeln('g=tgl');
		writeln('b=bulan');
		writeln('t=tahun');
		writeln('m=jenis member');
		writeln('n=nama'); 
		writeln('dan tekan(selain tombol tadi utk kembali ke menu) untuk keluar:   '); readln(pilihan);
	 case pilihan of
	  		's': begin
	  		     data[nilaicari].nama:='-';
                 data[nilaicari].tahun:=0;
                 data[nilaicari].bulan:='0';
                 data[nilaicari].tgl:=0;
                 data[nilaicari].jenis_member:='-';
                 data[nilaicari].total:=0;
                 n:=n-1;
	  		     end;

	  		'g':begin data[nilaicari].tgl:=0;            n:=n-1;  end;
            'b':begin data[nilaicari].bulan:='0';        n:=n-1;  end;
            't':begin data[nilaicari].tahun:=0;          n:=n-1;  end;
            'm':begin data[nilaicari].jenis_member:='-'; n:=n-1;  end;
            'n':begin data[nilaicari].nama:='-';         n:=n-1;  end;

            else
	  	end;
	  end
else 
write('data tidak ditemukan');
writeln;
writeln; 	
end;

  procedure cariberdasarkanmember(katakunci:string);
  var
  	k: Integer;
		   begin
		   repeat		   			   
		    case katakunci of
		    	'gold'   :begin
		    	          i:=1;
		    	          clrscr;
		    	          while (i <= nmax) do 
		    		      if (data[i].jenis_member = 'gold') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln;
                          writeln;
                          i:=i+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    	          end;

		    	'silver' :begin
		    	          i:=1;
		    	          while (i <= nmax) do 
		    		      if (data[i].jenis_member = 'silver') then
		    		      begin 
		    		      writeln('data ditemukan');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln;
                          writeln;
                          i:=i+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    	          end;

		     'platinum' : begin
		    	          i:=1;
		    	          while (i <= nmax) do 
		    		      if (data[i].jenis_member = 'platinum') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln;
                          writeln;
                          i:=i+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    	          end;

		    'n'         :begin
		    	
		                 end;

		    	    
		end;
		write('ingin lihaat lagi?(tekan sembarang jika iya tekan jika tidak)'); readln(katakunci);    
		until (katakunci = 'n');
		    end;

procedure cariberdasarkanbulan(data:id_struk; kunci:string);
           var
           	k: Integer;
		   begin
		  repeat
		    case kunci of
		    	'1'   :   begin
		    	          i:=1;
		    	          k:=0;
		    	          totalbulanan:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '1') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 1: ',totalbulanan:4:2);
		    		      writeln('banyaknya transaksi di bulan 1 adalah: ',k);
		    		      writeln;
		    	          end;

		    	'2' :     begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '2') then
		    		      begin 
		    		      writeln('data ditemukan');
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;
                          end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 2: ',totalbulanan:4:2);
		    		      writeln('banyaknya transaksi di bulan 2 adalah: ',k);
		    		      writeln;
		    	          end;

		     '3' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '3') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 3: ',totalbulanan:4:2);
		    		      writeln('banyaknya transaksi di bulan 3 adalah: ',k);
		    		      writeln;
		    	          end;
		    '4' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '4') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 4: ',totalbulanan:4:2);
		    		      writeln('banyaknya transaksi di bulan 4 adalah: ',k);
		    		      writeln;
		    	          end;
		    '5' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '5') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 5: ',totalbulanan:4:2);
		    		      writeln('banyaknya transaksi di bulan 5 adalah: ',k);
		    		      writeln;
		    	          end;
		    '6' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '6') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal:4:2);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
                          writeln('total belanja: ',data[i].total:4:2);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 6: ',totalbulanan:4:2);
		    		      writeln('banyaknya transaksi di bulan 6 adalah: ',k);
		    		      writeln;
		    	          end;
		    '7' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '7') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi);
                          writeln('total belanja: ',data[i].total);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('maaaf data tidak ketemu');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 7: ',totalbulanan);
		    		      writeln('banyaknya transaksi di bulan 7 adalah: ',k);
		    		      writeln;
		    	          end;
		    '8' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '8') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi);
                          writeln('total belanja: ',data[i].total);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 8: ',totalbulanan);
		    		      writeln('banyaknya transaksi di bulan 8 adalah: ',k);
		    		      writeln;
		    	          end;
		    '9' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '9') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi);
                          writeln('total belanja: ',data[i].total);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 9: ',totalbulanan);
		    		      writeln('banyaknya transaksi di bulan 9 adalah: ',k);
		    		      writeln;
		    	          end;
		    '10' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '10') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi);
                          writeln('total belanja: ',data[i].total);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 10: ',totalbulanan);
		    		      writeln('banyaknya transaksi di bulan 10 adalah: ',k);
		    		      writeln;
		    	          end;
		    '11' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '11') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi);
                          writeln('total belanja: ',data[i].total);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 11: ',totalbulanan);
		    		      writeln('banyaknya transaksi di bulan 11 adalah: ',k);
		    		      writeln;
		    	          end;
		    '12' : begin
		    	          i:=1;
		    	          k:=0;
		    	          while (i <= nmax) do 
		    		      if (data[i].bulan = '12') then
		    		      begin
		    		      writeln('data ditemukan'); 
		    		      writeln('=========================================================================================================================');
		    		      writeln('id: ',i);
		    		      writeln('nama member: ',data[i].nama);
                          writeln('tahun belanja: ',data[i].tahun);
                          writeln('bulan belanja: ',data[i].bulan);
                          writeln('tanggal belanja: ',data[i].tgl);
                          writeln('jenis member belanja belanja: ',data[i].jenis_member);
                          writeln('jumlahawal belanja: ',data[i].jumlahawal);
                          writeln('jumlahtransaksi: ',data[i].jumlahtransaksi);
                          writeln('total belanja: ',data[i].total);
                          hitungdiskon_dan_jumlahsetelahdiskon(data);
                          writeln('=========================================================================================================================');
                          totalbulanan:=totalbulanan+total;
                          writeln;
                          writeln;
                          i:=i+1;
                          k:=k+1;	
		    		      end
		    		      else
		    		      begin
		    		      writeln('-');
		    		      i:=i+1;
		    		      end;
		    		      writeln('total transkaksi di bulan 12: ',totalbulanan);
		    		      writeln('banyaknya transaksi di bulan 12 adalah: ',k);
		    		      writeln;
		    	          end;

           'n' : begin
           	     
                 end;

		    end;
		write('lihaat lagi hasil pencarian?(tekan n untuk tidaak)'); readln(katakunci);    
		until (katakunci = 'n');
		writeln;
		writeln('selesai');
		    end;

	procedure pilihansearch(ucok:char);
	var
		katakunci:string;
		k:integer;
	begin
	case ucok of
	'1' :  begin
	       while (katakunci <> 'n') do
	       begin
		   write('masukkan kata kunci member yg anda ingin cari(tekan n =keluar,gold/silver/platinum/sembaranag selain n untuk NONMEMBER/(harap memasukan kata kunci dengan lowercase)): '); readln(katakunci);
		   cariberdasarkanmember(katakunci);
		   write('ingin cariii lagii?(tekan sembarang tombol untuk iya tekan n untuk tidak) '); readln(katakunci);
		   end;
		   end;

		 
    '2' : begin
          while (katakunci <> 'n') do
          begin
		  write('masukkan bulan yg akan anda cari(tekan n =keluar): '); readln(katakunci);
          cariberdasarkanbulan(data,katakunci);
          write('ingin cariii lagii?(tekan sembarang tombol untuk iya tekan n untuk tidak) '); readln(katakunci);
		  end;
		  end;
		    
end;
end;

procedure searchdata(var data:id_struk);
	var
		pilihan:char;
		katakunci:string;
begin
	clrscr;
	writeln('1.untuk cari data berdasarkan member: ');
	writeln('2.untuk cari data berdasarkan bulan: ');
	readln(pilihan);
	pilihansearch(pilihan);
end;

procedure urutkandata(var data:id_struk);
	var
		j:Integer;
		tampung:datamasukkan;
		perintah:char;
begin
clrscr;
	for i:=1 to nmax-1 do
	begin
		for j:=nmax downto nmax-1 do
		begin
			if data[j].jumlahawal < data[j-1].jumlahawal then
			begin
			tampung:=data[j];
			data[j]:=data[j-1];
			data[j-1]:=tampung;	
			end
		end;
	end;
repeat
j:=1;
	while (j<=nmax) do
	begin
	if data[j].tahun = 0 then
	 begin
	 write(' ');
	 j:=j+1;
	 end
	else
	begin
	 writeln('=========================================================================================================================');
	 writeln('id: ',j);
	 writeln('nama member: ',data[j].nama);
     writeln('tahun belanja: ',data[j].tahun);
     writeln('bulan belanja: ',data[j].bulan);
     writeln('tanggal belanja: ',data[j].tgl);
     writeln('jenis member belanja belanja: ',data[j].jenis_member);
     writeln('jumlahawal belanja: ',data[j].jumlahawal:4:2);
     writeln('jumlahtransaksi: ',data[i].jumlahtransaksi:4:2);
     writeln('total belanja: ',data[i].total:4:2);
     writeln('=========================================================================================================================');
     writeln;
     writeln;
     j:=j+1;
     end;
	 end;
write('ulangi urut data?tekan sembarang untuk iya dan tekan n untuk tidak'); readln(perintah);
until perintah = 'n';
writeln;
writeln;
end;

procedure olahdata(var data:id_struk);
var
	k: Integer;
	perintah:char;
begin
	repeat
i:=1;
	while (i<=nmax) do
	begin
	if data[i].tahun = 0 then
	 begin
	 write(' ');
	 i:=i+1;
	 end
	else
	begin
	writeln('=========================================================================================================================');
	 writeln('id: ',i);
	 writeln('nama member: ',data[i].nama);
     writeln('tahun belanja: ',data[i].tahun);
     writeln('bulan belanja: ',data[i].bulan);
     writeln('tanggal belanja: ',data[i].tgl);
     writeln('jenis member belanja belanja: ',data[i].jenis_member);
     writeln('jumlahawal belanja: ',data[i].jumlahtransaksi:4:2);
     hitungdiskon_dan_jumlahsetelahdiskon(data);
     writeln('=========================================================================================================================');
     writeln;
     writeln;
     i:=i+1;
     end;
	 end;
write('input lagiii'); readln(perintah);
until perintah = 'n';
writeln;
writeln;
end;

procedure menu_utama(var data:id_struk; menu:char);
begin
readln(menu);
    case menu of
    '1' : inputdatakonsumen(data);
    '2' : showdatakonsumen(data);
    '3' : editdata(data);
    '4' : deletedata(data);
    '5' : searchdata(data);
    '6' : urutkandata(data);
    '7' : olahdata(data);
    'e' : begin
    	  a:=1;
          end;
    else
    writeln('pilihan anda salah periksa lagi kembali pilihan anda');
    end;
end;	

//=========================================================================================================================================================================================================================
begin
n:=0;
nmax:=5;
repeat
clrscr;	
write('selamat datang di program kasir super market');
	writeln;
	writeln('==============================================================================================================================');
	writeln('1.input data user baru');
	writeln('2.tampilkan semua data user');
	writeln('3.edit data user');
	writeln('4.hapus data user');
	writeln('5.cari data user tertentu');
	writeln('6.data ter urut user berdasarkan total awal');
	writeln('7.data user berikut pengeluarannya');
	writeln('e.keluar dari program');
	writeln('==============================================================================================================================');
    write('masukkan pilihan'); menu_utama(data,menu);
until a = 1;
write('sampai jumpaaa');
readln;
end.
//===========================================================================================================================================================================
