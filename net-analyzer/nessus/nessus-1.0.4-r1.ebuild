#Copyright 2000 Achim Gottinger
#Distributed under the GPL

# It's better to split it in four different packages

P=nessus-1.0.4
A="nessus-libraries-1.0.4.tar.gz nessus-core-1.0.4.tar.gz
   nessus-plugins-1.0.4.tar.gz libnasl-1.0.4.tar.gz libnasl-patch-1"
S=${WORKDIR}
DESCRIPTION="Nessus"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-1.0.4/src/nessus-libraries-1.0.4.tar.gz
	 ftp://ftp.nessus.org/pub/nessus/nessus-1.0.4/src/nessus-core-1.0.4.tar.gz
	 ftp://ftp.nessus.org/pub/nessus/nessus-1.0.4/src/nessus-plugins-1.0.4.tar.gz
	 ftp://ftp.nessus.org/pub/nessus/nessus-1.0.4/src/libnasl-1.0.4.tar.gz
	 ftp://ftp.nessus.org/pub/nessus/nessus-1.0.4/src/libnasl-patch-1"

HOMEPAGE="http://www.nessus.org/"

src_unpack () {
  unpack nessus-libraries-1.0.4.tar.gz
  unpack nessus-core-1.0.4.tar.gz
  unpack nessus-plugins-1.0.4.tar.gz
  unpack libnasl-1.0.4.tar.gz
  cd ${S}/libnasl/nasl
  patch -p0 < ${DISTDIR}/libnasl-patch-1
}
src_compile() {

  export PATH=${D}/usr/bin:$PATH
  export LD_LIBRARY_PATH=${D}/usr/lib:$LD_LIBRARY_PATH
  echo "Compiling libraries..."                           
  cd ${S}/nessus-libraries
  try ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var/state
  try make
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install
  cd ${D}/usr/bin
  cp nessus-config nessus-config.orig
  sed -e "s:^PREFIX=:PREFIX=${D}:" \
      -e "s:-I/usr:-I${D}/usr: " nessus-config.orig > nessus-config

  echo "Compiling libnasl..."
  cd ${S}/libnasl
  try ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var/state
  try make
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install
  cd ${D}/usr/bin
  cp nasl-config nasl-config.orig
  sed -e "s:^PREFIX=:PREFIX=${D}:" nasl-config.orig > nasl-config

  echo "Compiling core..."
  cd ${S}/nessus-core
  try ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var/state
  try make
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install


  echo "Compiling plugins..."
  cd ${S}/nessus-plugins
  try ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var/state
  try make
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install
 
}

src_install() {                               
  cd ${S}/nessus-libraries
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install

  cd ${S}/libnasl
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install

  cd ${S}/nessus-core
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install
  cp ${ROOT}/config/nessusd.conf ${D}/etc/nessus/
 
  cd ${S}/nessus-plugins
  try make prefix=${D}/usr sysconfdir=${D}/etc localstatedir=${D}/var/state install

  cd ${S}/nessus-libraries
  docinto nessus-libraries
  dodoc README* 

  cd ${S}/libnasl
  docinto libnasl
  dodoc COPYING TODO

  cd ${S}/nessus-core
  docinto nessus-core
  dodoc README* UPGRADE_README CHANGES
  dodoc doc/*.txt doc/ntp/*

  cd ${S}/nessus-plugins
  docinto nessus-plugins
  dodoc docs/*.txt plugins/accounts/accounts.txt
  prepman
}




