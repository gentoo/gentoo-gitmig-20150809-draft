# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.6.0.ebuild,v 1.4 2009/01/09 18:37:26 josejx Exp $

EAPI=1

inherit qt4 eutils flag-o-matic font toolchain-funcs

MY_P="${P/_}"

S="${WORKDIR}/${MY_P}"
FONT_S="${S}/lib/fonts"
FONT_SUFFIX="ttf"
DESCRIPTION="WYSIWYM frontend for LaTeX, DocBook, etc."
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.devel.lyx.org/pub/lyx/stable/${P}.tar.bz2"
#SRC_URI="http://www.lyx.org/~jamatos/lyx-1.6/${MY_P}.tar.bz2 #for betas
#SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.bz2"
#SRC_URI="ftp://ftp.devel.lyx.org/pub/lyx/pre/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cups debug nls latex monolithic-build html rtf dot docbook"
RESTRICT="test"

LANGS="ar ca cs de en es eu fi fr gl he hu it ja nb nn pl pt ro ru tr uk zh_CN zh_TW"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

COMMONDEPEND="|| ( ( x11-libs/qt-gui x11-libs/qt-core ) =x11-libs/qt-4.3*:4 )
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
	dev-libs/libxml2
	app-text/aiksaurus
	virtual/aspell-dict
	>=dev-lang/python-2.3.4
	media-libs/fontconfig
	media-libs/freetype
	>=dev-libs/boost-1.34"

RDEPEND="${COMMONDEPEND}
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	latex? (
		virtual/latex-base
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
	html? ( dev-tex/html2latex )
	rtf? (
			dev-tex/latex2rtf
			app-text/unrtf
			dev-tex/html2latex
		)
	linguas_he? ( dev-tex/culmus-latex )
	docbook? ( app-text/sgmltools-lite )
	dot? ( media-gfx/graphviz )"

DEPEND="${COMMONDEPEND}
	x11-proto/xproto
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

#bug 189925
QT4_BUILT_WITH_USE_CHECK="png"

src_compile() {
	tc-export CXX
	#bug 221921
	export VARTEXFONTS=${T}/fonts

	if use monolithic-build ; then
		MONOLITHIC=" --enable-monolithic-boost --enable-monolithic-client \
			--enable-monolithic-insets 	--enable-monolithic-mathed \
			--enable-monolithic-core --enable-monolithic-tex2lyx \
			--enable-monolithic-frontend-qt4 "
	fi

	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		$MONOLITHIC  \
		--with-aspell --without-included-boost --disable-stdlib-debug
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ANNOUNCE NEWS README RELEASE-NOTES UPGRADING "${FONT_S}"/*.txt

	if use linguas_he ; then
		echo "\bind_file cua" > "${T}"/hebrew.bind
		echo "\bind \"F12\" \"language hebrew\"" >> "${T}"/hebrew.bind

		insinto /usr/share/lyx/bind
		doins "${T}"/hebrew.bind
	fi

	doicon ${PN} "$S/development/Win32/packaging/icons/lyx_32x32.png"
	make_desktop_entry ${PN} "LyX" "/usr/share/pixmaps/lyx_32x32.png" "Office"

	# fix for bug 91108
	if use latex ; then
		dosym ../../../lyx/tex /usr/share/texmf/tex/latex/lyx
	fi

	# fonts needed for proper math display, see also bug #15629
	font_src_install
}

pkg_postinst() {
	font_pkg_postinst

	# fix for bug 91108
	if use latex ; then
		texhash
	fi

	# instructions for RTL support. See also bug 168331.
	if use linguas_he || use linguas_ar; then
		elog
		elog "Enabling RTL support in LyX:"
		elog "If you intend to use a RTL language (such as Hebrew or Arabic)"
		elog "You must enable RTL support in LyX. To do so start LyX and go to"
		elog "Tools->Preferences->Language settings->Language"
		elog "and make sure the \"Right-to-left language support\" is checked"
		elog
	fi
}

pkg_postrm() {
	if use latex ; then
		texhash
	fi
}
