# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-7.07.1-r1.ebuild,v 1.4 2004/03/07 19:28:46 psi29a Exp $

inherit eutils

DESCRIPTION="ESP Ghostscript -- an enhanced version of GNU Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/ghostscript.php"
SRC_URI="mirror://sourceforge/espgs/espgs-${PV}-source.tar.bz2
	ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/fonts/ghostscript-fonts-std-8.11.tar.gz
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz)"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="ia64 x86 ppc sparc alpha hppa amd64 ~mips"
IUSE="X cups cjk"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( virtual/x11 )
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	cups? ( net-print/cups )
	!virtual/ghostscript"

S=${WORKDIR}/espgs-${PV}

PROVIDE="virtual/ghostscript"

src_unpack() {
	unpack espgs-${PV}-source.tar.bz2
	unpack ghostscript-fonts-std-8.11.tar.gz

	cd ${S}

	if [ `use cjk` ] ; then
		epatch ${FILESDIR}/gs7.05.6-cjk.diff
		epatch ${FILESDIR}/gs7.05.6-kochi-substitute.patch
	fi

	# man page patch from absinthe@pobox.com (Dylan Carlson) bug #14150
	epatch ${FILESDIR}/ghostscript-7.05.6.man.patch

	# pxl dash patch
	epatch ${FILESDIR}/gs${PV}-ps2epsi.patch

	# ijs fPIC patch
	epatch ${FILESDIR}/gs${PV}-ijs.patch

	# pxl dash patch
	epatch ${FILESDIR}/gs7.05.6-gdevpx.patch

	# search path fix
	sed -i -e 's:$(gsdatadir)/lib:/usr/share/ghostscript/7.07/lib:' Makefile.in
	sed -i -e 's:$(gsdir)/fonts:/usr/share/ghostscript/fonts:' Makefile.in
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

	rm -fr ${D}/usr/share/ghostscript/7.07/doc || die
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
