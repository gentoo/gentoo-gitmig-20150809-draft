# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.5.7.ebuild,v 1.9 2011/04/16 10:59:16 ulm Exp $

EAPI=1

inherit qt4 eutils flag-o-matic font toolchain-funcs

MY_P="${P/_}"
S="${WORKDIR}/${MY_P}"
FONT_P="latex-xft-fonts-0.1"
FONT_S="${WORKDIR}/${FONT_P}"
DESCRIPTION="WYSIWYM frontend for LaTeX, DocBook, etc."
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/1.5.x/${P}.tar.bz2
	ftp://ftp.lyx.org/pub/lyx/contrib/${FONT_P}.tar.gz
	linguas_he? (
		http://cs.haifa.ac.il/~dekelts/lyx/files/hebrew.bind
		http://cs.haifa.ac.il/~dekelts/lyx/files/preferences
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="cups debug nls linguas_he latex"
RESTRICT="test"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-core:4
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXrender
	x11-libs/libXfixes
	x11-libs/libXext
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	media-gfx/imagemagick
	media-libs/libpng
	media-libs/fontconfig
	media-libs/freetype
	dev-libs/libxml2
	app-text/aiksaurus
	app-text/sgmltools-lite
	app-text/aspell
	>=dev-lang/python-2.3.4
	cups? ( virtual/lpr )
	latex? (
		virtual/latex-base
		app-text/ghostscript-gpl
		app-text/noweb
		dev-tex/dvipost
		dev-tex/chktex
		|| (
			dev-tex/latex2html
			dev-tex/tth
			dev-tex/hevea
			dev-tex/tex4ht
		)
	)
	linguas_he? ( dev-tex/ivritex )"

DEPEND="${RDEPEND}
	x11-proto/xproto
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug #125309
	epatch "${FILESDIR}"/${PN}-1.5.0-gentoo.patch || die
}

src_compile() {
	append-flags "$(test-flags -fno-stack-protector -fno-stack-protector-all)"
	replace-flags "-Os" "-O2"
	tc-export CXX

	unset LINGUAS
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		--with-aspell || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	local mylinguas="${LINGUAS}"

	unset LINGUAS
	emake DESTDIR="${D}" install || die "emake install failed"

	LINGUAS="${mylinguas}"

	dodoc ANNOUNCE ChangeLog NEWS README RELEASE-NOTES UPGRADING

	if use linguas_he ; then
		insinto /usr/share/lyx/bind
		doins "${DISTDIR}"/hebrew.bind
		dodoc "${DISTDIR}"/preferences
	fi

	domenu "${FILESDIR}"/lyx.desktop

	# install the latex-xft fonts, which should fix
	# the problems outlined in bug #15629
	# <obz@gentoo.org>
	cd "${WORKDIR}"/${FONT_P}
	emake DESTDIR="${D}" install || die "Font installation failed"

	font_src_install

	# fix for bug 91108
	if use latex ; then
		dosym ../../../lyx/tex /usr/share/texmf/tex/latex/lyx
	fi
}

pkg_postinst() {
	font_pkg_postinst

	# fix for bug 91108
	if use latex ; then
		texhash
	fi

	if use linguas_he ; then
		elog
		elog "How to use Hebrew in LyX:"
		elog "bunzip2 /usr/share/doc/${PF}/preferences.bz2 into ~/.lyx/preferences"
		elog "or, read http://cs.haifa.ac.il/~dekelts/lyx/instructions2.html"
		elog "for instructions on using lyx's own preferences dialog to equal effect."
		elog
	fi

	elog
	elog "There are known issues in the case of 1.4->1.5 config files transition."
	elog "In case your File->Export list is incomplete try reconfiguring or even"
	elog "remove the old configuration files in ~/.lyx ."
	elog
}

pkg_postrm() {
	if use latex ; then
		texhash
	fi
}
