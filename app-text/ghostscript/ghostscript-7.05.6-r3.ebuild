# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-7.05.6-r3.ebuild,v 1.10 2003/09/05 22:37:21 msterret Exp $

inherit eutils

DESCRIPTION="ESP Ghostscript -- an enhanced version of GNU Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/ghostscript.php"
SRC_URI="ftp://ftp.easysw.com/pub/ghostscript/espgs-${PV}-source.tar.bz2
	ftp://ftp.easysw.com/pub/ghostscript/gnu-gs-fonts-std-6.0.tar.gz
	ftp://ftp.easysw.com/pub/ghostscript/gnu-gs-fonts-other-6.0.tar.gz
	cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200204.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz)"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="X cups cjk"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( virtual/x11 )
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	cups? ( net-print/cups )"

S=${WORKDIR}/espgs-${PV}

src_unpack() {
	unpack espgs-${PV}-source.tar.bz2
	unpack gnu-gs-fonts-std-6.0.tar.gz
	unpack gnu-gs-fonts-other-6.0.tar.gz

	# Brother HL-12XX support
	cp ${FILESDIR}/gs7.05-gdevhl12.c ${S}/src/gdevhl12.c || die
	mv ${S}/src/Makefile.in ${S}/src/Makefile.in.orig
	sed 's#^\(DEVICE_DEVS6=.*\)$#\1 $(DD)hl1240.dev $(DD)hl1250.dev#' \
		${S}/src/Makefile.in.orig > ${S}/src/Makefile.in || die

	cd ${S}

##	patch -p0 < ${FILESDIR}/png.diff || die "patch failed"

	if [ `use cjk` ] ; then
		epatch ${FILESDIR}/gs${PV}-cjk.diff
		epatch ${FILESDIR}/gs${PV}-kochi-substitute.patch
	fi

	# man page patch from absinthe@pobox.com (Dylan Carlson) bug #14150
	epatch ${FILESDIR}/${P}.man.patch

	epatch ${FILESDIR}/ps2epsi-security.patch

	# bug 21627
	epatch ${FILESDIR}/gs${PV}-random.patch

	# ijs fPIC patch
	epatch ${FILESDIR}/ijs.patch
}

src_compile() {
	local myconf
	myconf="--with-ijs --with-omni --without-gimp-print"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use cups && myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"

	econf ${myconf}
	make || die "make failed"

	cd ijs
	econf --prefix=${D}/usr
	make || die "make failed"
	cd ..
}

src_install() {
	einstall install_prefix=${D}

	cd ${WORKDIR}
	cp -a fonts ${D}/usr/share/ghostscript || die
	cd ${S}

	rm -fr ${D}/usr/share/ghostscript/7.05/doc || die
	dodoc doc/README doc/COPYING doc/COPYING.LGPL
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

pkg_postinst() {
	einfo
	einfo "Only gimp-print 4.3.18 or higher are compatible with this ghostscript release!"
	einfo
}
