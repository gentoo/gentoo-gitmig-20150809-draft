# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.2.5.ebuild,v 1.0 2002/07/10 09:52:39 pm Exp


S=${WORKDIR}/${P}
DESCRIPTION="The AFS 3 distributed file system  targets the issues  critical to
distributed computing environments. AFS performs exceptionally well,
both within small, local work groups of machines and across wide-area
configurations in support of large, collaborative efforts. AFS provides
an architecture geared towards system management, along with the tools
to perform important management tasks. For a user, AFS is a familiar yet
extensive UNIX environment for accessing files easily and quickly."

SRC_URI="http://openafs.org/dl/openafs/1.2.5/openafs-1.2.5-src.tar.bz2"
HOMEPAGE="http://www.openafs.org/"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/pam-0.75"

ARCH=i386_linux24

src_unpack() {
	unpack ${A}

	cd ${S}/src/config
	cp Makefile.i386_linux24.in Makefile.i386_linux24.in.old
	sed -e "s|/usr/lib/libncurses.so|-lncurses|g" \
		Makefile.i386_linux24.in.old > Makefile.i386_linux24.in
	rm Makefile.i386_linux24.in.old
}

src_compile() {
	./configure \
		--with-afs-sysname=i386_linux24 \
		--enable-transarc-paths || die
	make || die
	make dest || die
}

src_install () {


  # Client

	cd ${S}/${ARCH}/dest/root.client/usr/vice
	
	insinto /etc/afs/modload
	doins etc/modload/*
	insinto /etc/afs/C
	doins etc/C/*

	insinto /etc/afs
	doins ${FILESDIR}/{ThisCell,CellServDB}
	doins etc/afs.conf

	dodir /afs

	exeinto /etc/init.d
	newexe ${FILESDIR}/afs.rc.rc6 afs

	dosbin etc/afsd

	# Client Bin
	cd ${S}/${ARCH}/dest
	exeinto /usr/afsws/bin
	doexe bin/*

	exeinto /etc/afs/afsws
	doexe etc/*

	cp -a include lib ${D}/usr/afsws
	dosym  /usr/afsws/lib/afs/libtermlib.a /usr/afsws/lib/afs/libnull.a

	# Server
	cd ${S}/${ARCH}/dest/root.server/usr/afs
	exeinto /usr/afs/bin
	doexe bin/*

	dodir /usr/vice
	dosym /etc/afs /usr/vice/etc
	dosym /etc/afs/afsws /usr/afsws/etc

	dodoc ${FILESDIR}/README
}

pkg_postinst () {
	echo ">>> UPDATE CellServDB and ThisCell to your needs !!"
	echo ">>> FOLLOW THE INSTRUCTIONS IN AFS QUICK BEGINNINGS"
	echo ">>> PAGE >45 TO DO INITIAL SERVER SETUP"    fi
}
