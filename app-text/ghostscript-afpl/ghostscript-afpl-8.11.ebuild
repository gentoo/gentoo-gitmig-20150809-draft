# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-afpl/ghostscript-afpl-8.11.ebuild,v 1.4 2004/01/08 15:00:53 lanius Exp $

inherit eutils

DESCRIPTION="AFPL Ghostscript"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/"
MY_PN="ghostscript"
MY_P=${MY_PN}-${PV}
SRC_URI="mirror://sourceforge/ghostscript/${MY_P}.tar.gz
	ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/fonts/${MY_PN}-fonts-std-${PV}.tar.gz
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz)
	cups? ( ftp://ftp.tu-clausthal.de/pub/linux/gentoo/distfiles/cups-1.1.20-source.tar.bz2 )"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="~x86"
IUSE="X cups cjk"

PROVIDE="virtual/ghostscript"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( virtual/x11 )
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	cups? ( >=net-print/cups-1.1.20 )
	gtk? ( =x11-libs/gtk+-1.2* )
	!virtual/ghostscript"

S=${WORKDIR}/${MY_P}

src_unpack() {
	cd ${WORKDIR}

	unpack ghostscript-${PV}.tar.gz
	unpack ghostscript-fonts-std-${PV}.tar.gz

	if [ `use cups` ]; then
		unpack cups-1.1.20-source.tar.bz2
		cp -r cups-1.1.20/pstoraster ${S}
		cd ${S}/pstoraster
		sed -e 's:@prefix@:/usr:' -e 's:@exec_prefix@:${prefix}:' -e 's:@bindir@:${exec_prefix}/bin:' -e 's:@GS@:gs:' pstopxl.in > pstopxl
		sed -i -e 's:/usr/local:/usr:' pstoraster
		sed -i -e "s:pstopcl6:pstopxl:" cups.mak
	fi

	cd ${S}

	use cups && epatch pstoraster/gs811-lib.patch

	# ijs patch
	epatch ${FILESDIR}/gs-${PV}-ijs.patch
}

src_compile() {
	myconf="--with-ijs"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use gtk || sed -i -e 's:$(INSTALL_PROGRAM) $(GSSOX):#:' src/unix-dll.mak \
		-e 's:$(GSSOX)::' src/unix-dll.mak

	econf ${myconf}

	use cups && echo 'include pstoraster/cups.mak' >> Makefile; sed -i -e 's:DEVICE_DEVS17=:DEVICE_DEVS17=$(DD)cups.dev:' Makefile

	# search path fix
	sed -i -e 's:$(gsdatadir)/lib:/usr/share/ghostscript/8.11/lib:' Makefile
	sed -i -e 's:$(gsdir)/fonts:/usr/share/ghostscript/fonts:' Makefile
	sed -i -e 's:$(gsdatadir)/Resource:/usr/share/ghostscript/8.11/Resource:' Makefile

	# includes fix
	use cups && sed -i -e 's:LDFLAGS=$(XLDFLAGS):LDFLAGS=-L/usr/include -lcups -lcupsimage $(XLDFLAGS):' Makefile

	make || die "make failed"
	make so || die "make so failed"

	cd ijs
	econf --prefix=${D}/usr
	make || die "make failed"
	cd ..
}

src_install() {
	einstall install_prefix=${D} soinstall

	cd ${WORKDIR}
	cp -a fonts ${D}/usr/share/ghostscript || die
	cd ${S}

	rm -fr ${D}/usr/share/ghostscript/${PV}/doc || die
	dodoc doc/README
	dohtml doc/*.html doc/*.htm
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el || die

	if [ `use cjk` ] ; then
		dodir /usr/share/ghostscript/Resource
		dodir /usr/share/ghostscript/Resource/Font
		dodir /usr/share/ghostscript/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	# Install ijs
	cd ${S}/ijs
	dodir /usr/bin /usr/include /usr/lib
	einstall install_prefix=${D}
}
