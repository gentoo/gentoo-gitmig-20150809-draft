#Copyright 2000 Achim Gottinger
#Distributed under the GPL
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus/nessus-1.0.9.ebuild,v 1.3 2002/05/23 06:50:15 seemant Exp $


# It's better to split it in four different packages

A="nessus-libraries-${PV}.tar.gz nessus-core-${PV}.tar.gz
   nessus-plugins-${PV}.tar.gz libnasl-${PV}.tar.gz"
S=${WORKDIR}
DESCRIPTION="A remote security scanner for Linux"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/nessus-libraries-${PV}.tar.gz
	 ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/nessus-core-${PV}.tar.gz
	 ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/nessus-plugins-${PV}.tar.gz
	 ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/libnasl-${PV}.tar.gz"

HOMEPAGE="http://www.nessus.org/"

DEPEND="virtual/glibc virtual/x11 sys-devel/m4
        >=dev-libs/gmp-3.1.1
        >=sys-libs/zlib-1.1.3
	=x11-libs/gtk+-1.2*"
RDEPEND="virtual/glibc virtual/x11
        >=dev-libs/gmp-3.1.1
        >=sys-libs/zlib-1.1.3
	=x11-libs/gtk+-1.2*"


src_compile() {

  export PATH=${D}/usr/bin:$PATH
  export LD_LIBRARY_PATH=${D}/usr/lib:$LD_LIBRARY_PATH

  echo "Compiling libraries..."
  cd ${S}/nessus-libraries
  ./configure \
	--host=${CHOST} 		\
	--prefix=/usr 			\
	--sysconfdir=/etc 		\
	--localstatedir=/var/state 	\
	--mandir=/usr/share/man 	\
	--enable-pthread || die
  make || die
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die

  cd ${D}/usr/bin
  cp nessus-config nessus-config.orig
  sed -e "s:^PREFIX=:PREFIX=${D}:" \
      -e "s:-I/usr:-I${D}/usr: " nessus-config.orig > nessus-config


  echo "Compiling libnasl..."
  cd ${S}/libnasl
  ./configure \
	--host=${CHOST} 		\
	--prefix=/usr 			\
	--sysconfdir=/etc 		\
	--localstatedir=/var/state 	\
	--mandir=/usr/share/man	|| die
  make || die
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die

  cd ${D}/usr/bin
  cp nasl-config nasl-config.orig
  sed -e "s:^PREFIX=:PREFIX=${D}:" nasl-config.orig > nasl-config

  echo "Compiling core..."
  cd ${S}/nessus-core
  ./configure \
	--host=${CHOST} 		\
	--prefix=/usr 			\
	--sysconfdir=/etc 		\
	--localstatedir=/var/state 	\
	--mandir=/usr/share/man || die
  make || die
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die


  echo "Compiling plugins..."
  cd ${S}/nessus-plugins
  ./configure \
	--host=${CHOST} 		\
	--prefix=/usr 			\
	--sysconfdir=/etc 		\
	--localstatedir=/var/state 	\
	--mandir=/usr/share/man
  make || die
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die

}

src_install() {

  cd ${S}/nessus-libraries
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die

  cd ${S}/libnasl
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die

  cd ${S}/nessus-core
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die

  cp ${ROOT}/config/nessusd.conf ${D}/etc/nessus/

  cd ${S}/nessus-plugins
  make \
	prefix=${D}/usr 		\
	sysconfdir=${D}/etc 		\
	localstatedir=${D}/var/state 	\
	mandir=${D}/usr/share/man 	\
	install || die

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

  insinto /etc/init.d
  insopts -m 755
  newins ${FILESDIR}/nessusd-r6 nessusd
}




