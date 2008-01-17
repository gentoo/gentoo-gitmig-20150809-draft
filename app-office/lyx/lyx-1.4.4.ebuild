# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.4.4.ebuild,v 1.4 2008/01/17 09:33:19 aballier Exp $

inherit kde-functions fdo-mime eutils libtool flag-o-matic font

FONT_PN="latex-xft-fonts"
FONT_S="${WORKDIR}/${FONT_PN}"
CJK_PATCH="CJK-LyX-qt-${PV}-1.patch"
DESCRIPTION="WYSIWYM frontend for LaTeX"
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.bz2
	ftp://ftp.lyx.org/pub/lyx/contrib/latex-xft-fonts-0.1.tar.gz
	http://cs.haifa.ac.il/~dekelts/lyx/files/hebrew.bind
	http://cs.haifa.ac.il/~dekelts//lyx/files/preferences
	qt3? ( cjk? ( ftp://cellular.phys.pusan.ac.kr/CJK-LyX/qt/${CJK_PATCH} ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cjk cups debug gtk nls qt3 gnome"

RDEPEND="x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXpm
	x11-libs/libXft
	virtual/ghostscript
	virtual/aspell-dict
	app-text/aiksaurus
	dev-tex/latex2html
	dev-tex/dvipost
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/sgmltools-lite
	app-text/noweb
	dev-tex/chktex
	qt3? ( =x11-libs/qt-3* )
	!qt3? (
		gtk? (
			>=dev-cpp/gtkmm-2.4
			>=dev-cpp/libglademm-2.4
		)
		!gtk? (
			=x11-libs/xforms-1*
		)
	)"

# these dependencies need looking at.
# does lyx only need qt to compile but not run ?
# I'll look into it <obz@gentoo.org>
DEPEND="${RDEPEND}
	x11-proto/xproto
	virtual/tetex
	>=dev-lang/perl-5
	nls? ( sys-devel/gettext )
	>=dev-lang/python-2.2
	>=sys-devel/autoconf-2.58
	"

src_unpack() {
	unpack ${P}.tar.bz2 || die "unpacking lyx failed"
	unpack latex-xft-fonts-0.1.tar.gz || die "unpacking xft-fonts failed"
	cd "${S}"
	# bug #125309
	epatch "${FILESDIR}"/${P}-gentoo.patch || die
	if use qt3 && use cjk ; then
		elog
		elog "CJK-LyX now only supports the qt frontend"
		elog "the xforms frontend has been removed."
		elog
		epatch "${DISTDIR}"/${CJK_PATCH} || die
	fi
	elibtoolize || die "elibtoolize failed "
}

src_compile() {
	local myconf=""

	# Choose qt over gtk, since gtk is not feature complete
	if use qt3 ; then
		set-qtdir 3
		myconf="$myconf --with-frontend=qt --with-qt-dir=${QTDIR}"
	elif use gtk ; then
		ewarn
		ewarn "GTK support for lyx is currently not feature complete."
		ewarn "Don't report any bugs about missing or faulty features to gentoo,"
		ewarn "instead you have the option of turning GTK support off by removing"
		ewarn "the gtk use flag or enable the qt3 use flag"
		ewarn "(or help implement the missing features at lyx.org)"
		ewarn
		myconf="$myconf --with-frontend=gtk"
	else
		myconf="$myconf --with-frontend=xforms"
	fi

	export WANT_AUTOCONF=2.5

	append-flags "$(test-flags -fno-stack-protector -fno-stack-protector-all)"
	replace-flags "-Os" "-O2"
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		--with-aspell \
		${myconf} \
		|| die "econf failed"

	# bug 57479
	emake || die "emake failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README* UPGRADING ChangeLog NEWS ANNOUNCE "${DISTDIR}"/preferences

	insinto /usr/share/lyx/bind
	doins "${DISTDIR}"/hebrew.bind

	domenu "${FILESDIR}"/lyx.desktop

	# install the latex-xft fonts, which should fix
	# the problems outlined in bug #15629
	# <obz@gentoo.org>
	cd "${WORKDIR}"/latex-xft-fonts-0.1
	emake DESTDIR="${D}" install || die "Font installation failed"

	font_src_install

	# bug #102310
	if use gnome ; then
		insinto /usr/share/icons/gnome/48x48/mimetypes
		doins "${FILESDIR}"/gnome-mime-application-x-lyx.png
	fi

	# fix for bug 91108
	dosym ../../../lyx/tex /usr/share/texmf/tex/latex/lyx
}

pkg_postinst() {
	font_pkg_postinst

	# fix for bug 91108
	texhash

	# bug #102310
	if use gnome ; then
		fdo-mime_desktop_database_update
	fi

	elog
	elog "How to use Hebrew in LyX:"
	elog "1. emerge dev-tex/ivritex."
	elog "2. gunzip /usr/share/doc/${PF}/preferences.gz into ~/.lyx/preferences"
	elog "or, read http://www.math.tau.ac.il/~dekelts/lyx/instructions2.html"
	elog "for instructions on using lyx's own preferences dialog to equal effect."
	elog "3. use lyx's qt interface (compile with USE=qt3) for maximum effect."
	elog

	if ! use qt3 ; then
		elog
		elog "If you have a multi-head setup not using xinerama you can only use lyx"
		elog "on the 2nd head if not using qt (maybe due to a xforms bug). See bug #40392."
		elog
	fi
}
