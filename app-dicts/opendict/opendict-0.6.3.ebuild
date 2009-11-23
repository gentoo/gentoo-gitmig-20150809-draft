# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/opendict/opendict-0.6.3.ebuild,v 1.1 2009/11/23 00:22:01 dirtyepic Exp $

EAPI=2

inherit eutils python gnome2

DESCRIPTION="OpenDict is a free cross-platform dictionary program."
HOMEPAGE="http://opendict.sourceforge.net/"
SRC_URI="http://opendict.idiles.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/python-2.3
	dev-python/wxpython:2.8
	dev-python/pyxml"

src_prepare() {
	#epatch "${FILESDIR}/${PN}-0.6.1-desktop.patch"
	sed -e "s:), '..')):), '../../../../..', 'share', 'opendict')):g" \
		-i "${S}/lib/info.py"
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	python_version
	DHOME="/usr/lib/python${PYVER}/site-packages/opendict"

	dodir /usr/share/${PN}/dictionaries/plugins # global dictionary plugins folder

	# Needed by GUI
	insinto /usr/share/${PN}
	doins "${S}"/copying.html

	insinto "${DHOME}/lib"
	doins -r "${S}"/lib/*

	insinto /usr/share/${PN}/pixmaps
	doins "${S}"/pixmaps/*

	exeinto "${DHOME}"
	doexe opendict.py

	dosym "${DHOME}/opendict.py" /usr/bin/opendict

	domenu misc/${PN}.desktop

	insinto /usr/share/icons/hicolor/24x24/apps/
	newins "${S}/pixmaps/icon-24x24.png" opendict.png
	insinto /usr/share/icons/hicolor/32x32/apps/
	newins "${S}/pixmaps/icon-32x32.png" opendict.png
	insinto /usr/share/icons/hicolor/48x48/apps/
	newins "${S}/pixmaps/icon-48x48.png" opendict.png
	insinto /usr/share/icons/hicolor/scalable/apps/
	newins "${S}/pixmaps/SVG/icon-rune.svg" opendict.svg

	doman opendict.1
	dodoc README.txt TODO.txt doc/Plugin-HOWTO.html
}

pkg_postinst() {
	python_mod_optimize \
		/usr/$(get_libdir)/python${PYVER}/site-packages/opendict
	gnome2_icon_cache_update

	elog "If you want system-wide plugins, unzip them into"
	elog "${ROOT}usr/share/${PN}/dictionaries/plugins"
	elog "Some are available from http://opendict.sourceforge.net/?cid=3"
}

pkg_postrm() {
	python_mod_cleanup
	gnome2_icon_cache_update
}
