# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.3.5.ebuild,v 1.3 2004/10/22 02:29:16 usata Exp $

inherit kde-functions eutils libtool

DESCRIPTION="WYSIWYM frontend for LaTeX"
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.bz2
	http://movementarian.org/latex-xft-fonts-0.1.tar.gz
	http://www.math.tau.ac.il/~dekelts/lyx/files/hebrew.bind
	http://www.math.tau.ac.il/~dekelts/lyx/files/preferences"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="nls cups qt debug gnome"

# these dependencies need looking at.
# does lyx only need qt to compile but not run ?
# I'll look into it <obz@gentoo.org>
DEPEND="virtual/x11
	virtual/tetex
	>=dev-lang/perl-5
	nls? ( sys-devel/gettext )
	app-text/aiksaurus
	qt? ( >=x11-libs/qt-3 ) !qt? ( =x11-libs/xforms-1* )"

RDEPEND="${DEPEND}
	virtual/ghostscript
	app-text/xpdf
	virtual/aspell-dict
	app-text/gv
	dev-tex/latex2html
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/rcs
	dev-util/cvs
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
	elibtoolize || die
}

src_compile() {
	local myconf=""
	if use qt ; then
		set-qtdir 3
		myconf="$myconf --with-frontend=qt --with-qt-dir=${QTDIR}"
	else
		myconf="$myconf --with-frontend=xforms"
	fi

	export WANT_AUTOCONF=2.5

	local flags="${CFLAGS}"
	unset CFLAGS
	unset CXXFLAGS
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		${myconf} \
		--enable-optimization="$flags" \
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

	# gnome menu entry
	if use gnome; then
		insinto /usr/share/applications
		doins ${FILESDIR}/lyx.desktop
	fi

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

	einfo ""
	einfo "================"
	einfo ""
	einfo "How to use Hebrew in LyX:"
	einfo "1. emerge app-text/ivritex."
	einfo "2. unzip /usr/share/doc/${P}/preferences.gz into ~/.lyx/preferences"
	einfo "or, read http://www.math.tau.ac.il/~dekelts/lyx/instructions2.html"
	einfo "for instructions on using lyx's own preferences dialog to equal effect."
	einfo "3. use lyx's qt interface (compile with USE=qt) for maximum effect."
	einfo ""

	if ! use qt ; then
	einfo "================"
	einfo ""
	einfo "If you have a multi-head setup not using xinerama you can only use lyx"
	einfo "on the 2nd head if not using qt (maybe due to a xforms bug). See bug #40392."
	einfo ""
	fi
}
