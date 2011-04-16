# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/opendict/opendict-0.6.1.ebuild,v 1.10 2011/04/16 19:55:39 arfrever Exp $

EAPI=3

inherit eutils python gnome2

DESCRIPTION="OpenDict is a free cross-platform dictionary program."
HOMEPAGE="http://opendict.sourceforge.net/"
SRC_URI="mirror://sourceforge/opendict/OpenDict-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
# DEPEND=">=sys-devel/gettext-0.14" # currently no xgettext run
RDEPEND=">=dev-lang/python-2.3
	=dev-python/wxpython-2.6*
	dev-python/pyxml"
S="${WORKDIR}/OpenDict-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.1-desktop.patch"
	sed -e "s:), '..')):), '../../../../..', 'share', 'opendict')):g" \
		-i "${S}/lib/info.py"
}

src_configure() {
	default
}

src_compile() {
	:
}

src_install() {
	DHOME="$(python_get_sitedir)/opendict"
	#dodir /usr/share/locale/lt/LC_MESSAGES

	dodir /usr/share/${PN}
	dodir /usr/share/${PN}/dictionaries # global dictionary folder
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

	dodir /usr/bin
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
	dodoc ChangeLog README.txt TODO.txt doc/Plugin-HOWTO.html
}

pkg_postinst() {
	python_mod_optimize opendict
	gnome2_icon_cache_update

	elog "If you want system-wide plugins, unzip them into"
	elog "${ROOT}usr/share/${PN}/dictionaries/plugins"
	elog "Some are available from http://opendict.sourceforge.net/?cid=3"
}

pkg_postrm() {
	python_mod_cleanup opendict
	gnome2_icon_cache_update
}
