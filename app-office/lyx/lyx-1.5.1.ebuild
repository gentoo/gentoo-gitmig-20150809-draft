# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.5.1.ebuild,v 1.2 2007/09/22 17:34:16 nixnut Exp $

inherit qt4 eutils flag-o-matic font

MY_P="${P/_}"
S="${WORKDIR}/${MY_P}"
FONT_P="latex-xft-fonts-0.1"
FONT_S="${WORKDIR}/${FONT_P}"
DESCRIPTION="WYSIWYM frontend for LaTeX, DocBook, etc."
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.bz2
	ftp://ftp.lyx.org/pub/lyx/contrib/${FONT_P}.tar.gz
	linguas_he? (
		http://cs.haifa.ac.il/~dekelts/lyx/files/hebrew.bind
		http://cs.haifa.ac.il/~dekelts/lyx/files/preferences
	)"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS="~amd64 ~ppc ~sparc ~x86" # dev-tex/ivritex
IUSE="cups debug nls linguas_he tetex"
RESTRICT="test"

RDEPEND="$(qt4_min_version 4.1.1)
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXft
	virtual/aspell-dict
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/sgmltools-lite
	tetex? (
		virtual/ghostscript
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

# these dependencies need looking at.
# does lyx only need qt to compile but not run ?
# I'll look into it <obz@gentoo.org>
DEPEND="${RDEPEND}
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXpm
	x11-proto/xproto
	tetex? ( virtual/tetex )
	nls? ( sys-devel/gettext )
	app-text/aiksaurus
	>=dev-lang/python-2.3.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug #125309
	epatch "${FILESDIR}"/${PN}-1.5.0-gentoo.patch || die
}

src_compile() {
	append-flags "$(test-flags -fno-stack-protector -fno-stack-protector-all)"
	replace-flags "-Os" "-O2"

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
	if use tetex ; then
		dosym ../../../lyx/tex /usr/share/texmf/tex/latex/lyx
	fi
}

pkg_postinst() {
	font_pkg_postinst

	# fix for bug 91108
	if use tetex ; then
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
}

pkg_postrm() {
	if use tetex ; then
		texhash
	fi
}
