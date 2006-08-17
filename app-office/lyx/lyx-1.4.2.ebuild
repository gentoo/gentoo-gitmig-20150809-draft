# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.4.2.ebuild,v 1.1 2006/08/17 23:02:01 matsuu Exp $

inherit kde-functions fdo-mime eutils libtool flag-o-matic

CJK_PATCH="CJK-LyX-qt-${PV}-1.patch"
DESCRIPTION="WYSIWYM frontend for LaTeX"
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.bz2
	ftp://ftp.lyx.org/pub/lyx/contrib/latex-xft-fonts-0.1.tar.gz
	http://www.math.tau.ac.il/~dekelts/lyx/files/hebrew.bind
	http://www.math.tau.ac.il/~dekelts/lyx/files/preferences
	qt3? ( cjk? ( ftp://cellular.phys.pusan.ac.kr/CJK-LyX/qt/${CJK_PATCH} ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cjk cups debug gtk nls qt3 gnome"

RDEPEND="|| (
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
	dev-tex/dvipost
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/sgmltools-lite
	app-text/noweb
	dev-tex/chktex"

# these dependencies need looking at.
# does lyx only need qt to compile but not run ?
# I'll look into it <obz@gentoo.org>
DEPEND="${RDEPEND}
	|| (
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
	dev-lang/python
	>=sys-devel/autoconf-2.58
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

src_unpack() {
	unpack ${P}.tar.bz2 || die "unpacking lyx failed"
	unpack latex-xft-fonts-0.1.tar.gz || die "unpacking xft-fonts failed"
	cd "${S}"
	# bug #125309
	epatch "${FILESDIR}"/${P}-gentoo.patch || die
	if use qt3 && use cjk ; then
		einfo
		einfo "CJK-LyX now only supports the qt frontend"
		einfo "the xforms frontend has been removed."
		einfo
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

	dodoc README* UPGRADING ChangeLog NEWS ANNOUNCE ABOUT-NLS "${DISTDIR}"/preferences

	insinto /usr/share/lyx/bind
	doins "${DISTDIR}"/hebrew.bind

	domenu "${FILESDIR}"/lyx.desktop

	# install the latex-xft fonts, which should fix
	# the problems outlined in bug #15629
	# <obz@gentoo.org>
	cd "${WORKDIR}"/latex-xft-fonts-0.1
	emake DESTDIR="${D}" install || die "Font installation failed"

	mkfontscale "${D}"/usr/share/fonts/latex-xft-fonts
	mkfontdir -e /usr/share/fonts/encodings \
		-e /usr/share/fonts/encodings/large \
		-e /usr/X11R6/$(get_libdir)/X11/fonts/encodings \
		"${D}"/usr/share/fonts/latex-xft-fonts
	HOME=/root fc-cache -f "${D}"/usr/share/fonts/latex-xft-fonts

	# bug #102310
	if use gnome ; then
		insinto /usr/share/icons/gnome/48x48/mimetypes
		doins "${FILESDIR}"/gnome-mime-application-x-lyx.png
	fi

	# fix for bug 91108
	dosym ../../../lyx/tex /usr/share/texmf/tex/latex/lyx
}

pkg_postinst() {
	# fix for bug 91108
	texhash

	# bug #102310
	if use gnome ; then
		fdo-mime_desktop_database_update
	fi

	einfo ""
	einfo "How to use Hebrew in LyX:"
	einfo "1. emerge dev-tex/ivritex."
	einfo "2. gunzip /usr/share/doc/${PF}/preferences.gz into ~/.lyx/preferences"
	einfo "or, read http://www.math.tau.ac.il/~dekelts/lyx/instructions2.html"
	einfo "for instructions on using lyx's own preferences dialog to equal effect."
	einfo "3. use lyx's qt interface (compile with USE=qt3) for maximum effect."
	einfo ""

	if ! use qt3 ; then
		einfo ""
		einfo "If you have a multi-head setup not using xinerama you can only use lyx"
		einfo "on the 2nd head if not using qt (maybe due to a xforms bug). See bug #40392."
		einfo ""
	fi
}
