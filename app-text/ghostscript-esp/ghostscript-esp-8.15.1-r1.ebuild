# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-esp/ghostscript-esp-8.15.1-r1.ebuild,v 1.3 2006/04/23 09:45:33 flameeyes Exp $

inherit eutils autotools flag-o-matic

DESCRIPTION="ESP Ghostscript -- an enhanced version of GPL Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/espgs"

MY_P=espgs-${PV}
PVM=${PV%.[0-9]}
SRC_URI="http://ftp.easysw.com/pub/ghostscript/${PV}/espgs-${PV}-source.tar.bz2
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="X cups cjk emacs gtk threads xml"

DEP="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( || ( x11-libs/libXt virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( >=net-print/cups-1.1.20 )
	xml? ( >=dev-libs/libxml2-2.6.8 )
	!app-text/ghostscript-gnu
	!app-text/ghostscript-afpl"

RDEPEND="${DEP}
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	media-fonts/gnu-gs-fonts-std"

DEPEND="${DEP}
	gtk? ( dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A/adobe-cmaps-200204.tar.gz acro5-cmaps-2001.tar.gz}
	cd ${S}

	epatch ${FILESDIR}/gs-${PV}destdir.patch
	epatch ${FILESDIR}/ghostscript-build.patch
	epatch ${FILESDIR}/ghostscript-scripts.patch
	epatch ${FILESDIR}/ghostscript-ps2epsi.patch
	epatch ${FILESDIR}/ghostscript-badc.patch
	epatch ${FILESDIR}/ghostscript-pagesize.patch
	epatch ${FILESDIR}/ghostscript-noopt.patch
	epatch ${FILESDIR}/ghostscript-use-external-freetype.patch
	epatch ${FILESDIR}/ghostscript-split-font-configuration.patch
	epatch ${FILESDIR}/${P}-fPIC.patch
	epatch ${FILESDIR}/${P}-bsd.patch

	# not submitted
	epatch ${FILESDIR}/ijs-dirinstall.diff
	epatch ${FILESDIR}/ghostscript-gtk2.patch
	if ! use gtk; then
		sed -i "s:\$(GSSOX)::" src/*.mak || die "gsx sed failed"
		sed -i "s:.*\$(GSSOX_XENAME)$::" src/*.mak || die "gsxso sed failed"
	fi

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		Makefile.in || die "sed failed"

	# #128647
	epatch ${FILESDIR}/${P}-ps2epsi-esp.diff
	sed -i "s/Id:.*//" pstoraster/pstoraster.convs

	AT_NOELIBTOOLIZE="yes" eautoreconf
	cd ijs
	AT_NOELIBTOOLIZE="yes" eautoreconf

	elibtoolize
}

src_compile() {
	local myconf
	myconf="--with-ijs --with-jbig2dec"

	# gs -DPARANOIDSAFER out.ps
	myconf="${myconf} --with-fontconfig --with-fontpath=/usr/share/fonts:/usr/share/fonts/ttf/zh_TW:/usr/share/fonts/ttf/zh_CN:/usr/share/fonts/arphicfonts:/usr/share/fonts/ttf/korean/baekmuk:/usr/share/fonts/baekmuk-fonts:/usr/X11R6/lib/X11/fonts/truetype:/usr/share/fonts/kochi-substitute"

	# *-dynmic breaks compiling without X, see bug 121749
	use X && myconf="${myconf} --enable-dynamic"

	econf $(use_with X x) \
		$(use_enable cups) \
		$(use_enable threads) \
		$(use_with xml omni) \
		${myconf} || die "econf failed"
	emake -j1 || die "make failed"
	emake so -j1 || die "make failed"

	cd ijs
	econf || die "econf failed"
	emake -j1 || die "make failed"
	cd ..
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	make DESTDIR="${D}" soinstall || die "make install failed"

	rm -fr ${D}/usr/share/ghostscript/${PVM}/doc || die
	dodoc doc/README
	dohtml doc/*.html doc/*.htm

	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins doc/gsdoc.el
	fi

	if use cjk; then
		dodir /usr/share/ghostscript/Resource
		dodir /usr/share/ghostscript/Resource/Font
		dodir /usr/share/ghostscript/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	# install ijs
	cd ${S}/ijs
	make DESTDIR="${D}" install || die "ijs install failed"
}
