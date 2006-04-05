# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.3.5-r1.ebuild,v 1.12 2006/04/05 07:32:03 ehmsen Exp $

inherit kde-functions eutils libtool flag-o-matic

DESCRIPTION="WYSIWYM frontend for LaTeX"
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.bz2
	http://movementarian.org/latex-xft-fonts-0.1.tar.gz
	http://www.math.tau.ac.il/~dekelts/lyx/files/hebrew.bind
	http://www.math.tau.ac.il/~dekelts/lyx/files/preferences
	cjk? ( qt? ( ftp://cellular.phys.pusan.ac.kr/CJK-LyX/qt/CJK-LyX-qt-${PV}-1.patch )
		!qt? ( ftp://cellular.phys.pusan.ac.kr/CJK-LyX/xforms/CJK-LyX-xforms-${PV}-1.patch ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="cjk cups debug nls qt"

# these dependencies need looking at.
# does lyx only need qt to compile but not run ?
# I'll look into it <obz@gentoo.org>
DEPEND="|| (
		virtual/x11
		(
			x11-libs/libX11
			x11-libs/libXt
			x11-libs/libXpm
			x11-proto/xproto
		)
	)
	virtual/tetex
	>=dev-lang/perl-5
	nls? ( sys-devel/gettext )
	app-text/aiksaurus
	qt? ( =x11-libs/qt-3* )
	!qt? ( cjk? ( =x11-libs/xforms-1.0-r1 )
		!cjk? ( =x11-libs/xforms-1* ) )"

RDEPEND="${DEPEND}
	|| (
		virtual/x11
		(
			x11-libs/libXi
			x11-libs/libXrandr
			x11-libs/libXcursor
			x11-libs/libXft
		)
	)
	virtual/ghostscript
	virtual/aspell-dict
	dev-tex/latex2html
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/sgmltools-lite
	app-text/noweb
	dev-tex/chktex"

DEPEND="$DEPEND >=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${P}.tar.bz2
	unpack latex-xft-fonts-0.1.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.3.2-nomktex.patch
	epatch ${FILESDIR}/${PN}-1.3.3-configure-diff
	epatch ${FILESDIR}/${P}-boost.patch
	if use cjk && use qt ; then
		epatch ${DISTDIR}/CJK-LyX-qt-${PV}-1.patch
	elif use cjk && built_with_use '=x11-libs/xforms-1.0-r1' cjk ; then
		epatch ${DISTDIR}/CJK-LyX-xforms-${PV}-1.patch
	elif use cjk ; then
		eerror
		eerror 'CJK-LyX requires qt USE flag enabled or x11-libs/xforms-1.0-r1'
		eerror 'built with cjk USE flag. You should either'
		eerror '1) USE="cjk qt" emerge lyx'
		eerror 'or'
		eerror '2) USE="cjk" emerge xforms-1.0-r1; USE="cjk -qt" emerge lyx'
		eerror 'or'
		eerror '3) USE="-cjk" emerge lyx (normal LyX will be built)'
		eerror
		die "Please remerge xforms-1.0-r1 with cjk USE flag enabled."
	fi
	elibtoolize || die
}

src_compile() {
	local myconf=""
	if use qt ; then
		set-qtdir 3
		myconf="$myconf --with-frontend=qt --with-qt-dir=${QTDIR}"
	else
		export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include/X11"
		myconf="$myconf --with-frontend=xforms"
	fi

	export WANT_AUTOCONF=2.5

	local flags="${CXXFLAGS} $(test_flag -fno-stack-protector) $(test_flag -fno-stack-protector-all)"
	unset CFLAGS
	unset CXXFLAGS
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		${myconf} \
		--enable-optimization="${flags/-Os}" \
		|| die
	# bug 57479
	emake || die "emake failed"

}

src_install() {
	einstall || die
	dodoc README* UPGRADING INSTALL* ChangeLog NEWS COPYING \
		ANNOUNCE ABOUT-NLS ${DISTDIR}/preferences
	insinto /usr/share/lyx/bind
	doins ${DISTDIR}/hebrew.bind

	domenu ${FILESDIR}/lyx.desktop

	# install the latex-xft fonts, which should fix
	# the problems outlined in bug #15629
	# <obz@gentoo.org>
	cd ${WORKDIR}/latex-xft-fonts-0.1
	make DESTDIR=${D} install || die "Font installation failed"

	mkfontscale ${D}/usr/share/fonts/latex-xft-fonts
	mkfontdir -e /usr/share/fonts/encodings \
		-e /usr/share/fonts/encodings/large \
		-e /usr/X11R6/$(get_libdir)/X11/fonts/encodings \
		${D}/usr/share/fonts/latex-xft-fonts
	HOME=/root fc-cache -f ${D}/usr/share/fonts/latex-xft-fonts
}

pkg_postinst() {

	draw_line
	einfo ""
	einfo "How to use Hebrew in LyX:"
	einfo "1. emerge app-text/ivritex."
	einfo "2. unzip /usr/share/doc/${P}/preferences.gz into ~/.lyx/preferences"
	einfo "or, read http://www.math.tau.ac.il/~dekelts/lyx/instructions2.html"
	einfo "for instructions on using lyx's own preferences dialog to equal effect."
	einfo "3. use lyx's qt interface (compile with USE=qt) for maximum effect."
	einfo ""

	if ! useq qt ; then
	draw_line
	einfo ""
	einfo "If you have a multi-head setup not using xinerama you can only use lyx"
	einfo "on the 2nd head if not using qt (maybe due to a xforms bug). See bug #40392."
	einfo ""
	fi
}
