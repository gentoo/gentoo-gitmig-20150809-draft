# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-7.05.6-r2.ebuild,v 1.10 2004/10/19 09:29:14 sejo Exp $

inherit eutils

DESCRIPTION="ESP Ghostscript -- an enhanced version of GNU Ghostscript with better printer support"
SRC_URI="ftp://ftp.easysw.com/pub/ghostscript/espgs-${PV}-source.tar.bz2
	cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200204.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz)"
HOMEPAGE="http://www.easysw.com/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="ppc"
IUSE="X cups cjk"

DEPEND="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( virtual/x11 )
	cjk? ( <=media-fonts/arphicfonts-0.1-r1
		<=media-fonts/kochi-substitute-20030809-r2
		<=media-fonts/baekmuk-fonts-2.1-r1 )
	cups? ( net-print/cups )
	!virtual/ghostscript
	media-fonts/gnu-gs-fonts-std"

PROVIDE="virtual/ghostscript"

S=${WORKDIR}/espgs-${PV}

src_unpack() {
	unpack espgs-${PV}-source.tar.bz2

	# Brother HL-12XX support
	cp ${FILESDIR}/gs7.05-gdevhl12.c.bz2 ${S}/src/gdevhl12.c.bz2 || die
	bzip2 -df ${S}/src/gdevhl12.c.bz2 || die
	mv ${S}/src/Makefile.in ${S}/src/Makefile.in.orig
	sed 's#^\(DEVICE_DEVS6=.*\)$#\1 $(DD)hl1240.dev $(DD)hl1250.dev#' \
		${S}/src/Makefile.in.orig > ${S}/src/Makefile.in || die

##	patch -p0 < ${FILESDIR}/png.diff || die "patch failed"

	use cjk && epatch ${FILESDIR}/gs${PV}-cjk.diff.bz2

	# man page patch from absinthe@pobox.com (Dylan Carlson) bug #14150
	patch -p0 ${S}/man/gs.1 < ${FILESDIR}/${P}.man.patch || die

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/7.05/$(get_libdir):"\
	${S}/src/Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
	${S}/src/Makefile.in || die "sed failed"

	# fix insecure tempfile handling
	epatch ${FILESDIR}/gs${PV}-tempfile.patch

}

src_compile() {
	local myconf
	myconf="--with-ijs --with-omni"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use cups && myconf="${myconf} --enable-cups --with-gimp-print" \
		|| myconf="${myconf} --disable-cups --without-gimp-print"

	econf ${myconf} || die "econf failed"
	make || die "make failed"
}

src_install() {
	einstall install_prefix=${D}

	rm -fr ${D}/usr/share/ghostscript/7.05/doc || die
	dodoc doc/README doc/COPYING doc/COPYING.LGPL
	dohtml doc/*.html doc/*.htm
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el || die

	if use cjk ; then
		dodir /usr/share/ghostscript/Resource
		dodir /usr/share/ghostscript/Resource/Font
		dodir /usr/share/ghostscript/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi
}
