# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/codeblocks/codeblocks-8.02-r1.ebuild,v 1.3 2010/05/06 06:08:10 dirtyepic Exp $

inherit autotools wxwidgets flag-o-matic eutils

WX_GTK_VER="2.8"

DESCRIPTION="Free cross-platform C/C++ IDE"
HOMEPAGE="http://www.codeblocks.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
SRC_URI="mirror://sourceforge/codeblocks/${P}-src.tar.bz2"

IUSE="contrib debug pch static"

RDEPEND="=x11-libs/wxGTK-${WX_GTK_VER}*
		x11-libs/gtk+"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.5.0
	>=sys-devel/automake-1.7
	>=sys-devel/libtool-1.4
	app-arch/zip"

pkg_setup() {
		need-wxwidgets unicode
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PV}-version.patch"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch
	#epatch "${FILESDIR}/${PV}-install-plugins.patch"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gsocket.patch
	find src/plugins -name Makefile.am -exec \
		sed -i -e 's#^libdir#pluginsdir#' \
			   -e 's#^lib_LTLIBRARIES#plugins_LTLIBRARIES#' \
		'{}' \;
	# This one's buggy
	sed -i -e 's#^plugins_LTLIBRARIES#lib_LTLIBRARIES#' \
		src/plugins/contrib/wxSmith/Makefile.am

	eautoreconf || die "autoreconf failed"
#	./bootstrap || die "boostrap failed"
}

src_compile() {
	# C::B is picky on CXXFLAG -fomit-frame-pointer
	# (project-wizard crash, instability ...)
	filter-flags -fomit-frame-pointer
	append-flags -fno-strict-aliasing

	cd "${S}"
	local myconf="$(use_enable pch)"
#			$(use_enable autosave) \
#			$(use_enable class-wizard) \
#			$(use_enable code-completion) \
#			$(use_enable compiler) \
#			$(use_enable debuger) \
#			$(use_enable mime-handler) \
#			$(use_enable open-files-list) \
#
#			$(use_enable projects-importer) \
#			$(use_enable source-formatter) \
#			$(use_enable todo) \
#			$(use_enable xpmanifest)

	if use contrib; then
		myconf="${myconf} --with-contrib-plugins=all"
	fi
	econf	--with-wx-config="${WX_CONFIG}" \
			--enable-dependency-tracking \
			$(use_enable debug) \
			$(use_enable static) \
			${myconf} || die "Died in action: econf ..."
	emake || die "Died in action: make ..."
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
