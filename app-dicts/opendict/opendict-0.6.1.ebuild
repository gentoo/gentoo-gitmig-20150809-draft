# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/opendict/opendict-0.6.1.ebuild,v 1.1 2006/04/21 04:25:21 halcy0n Exp $

inherit eutils python gnome2

DESCRIPTION="OpenDict is a free cross-platform dictionary program."
HOMEPAGE="http://opendict.sourceforge.net/"
SRC_URI="mirror://sourceforge/opendict/OpenDict-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
# DEPEND=">=sys-devel/gettext-0.14" # currently no xgettext run
RDEPEND=">=virtual/python-2.3
	>=dev-python/wxpython-2.6
	dev-python/pyxml"
S="${WORKDIR}/OpenDict-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.6.1-desktop.patch"
	sed -e "s:), '..')):), '../../../../..', 'share', 'opendict')):g" \
		-i "${S}/lib/info.py"
}

src_compile() {
	:
}

src_install() {
	python_version
	DHOME="/usr/lib/python${PYVER}/site-packages/opendict"

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
	gnome2_icon_cache_update

	einfo "If you want system-wide plugins, unzip them into"
	einfo "${ROOT}usr/share/${PN}/dictionaries/plugins"
	einfo "Some are available from http://opendict.sourceforge.net/?cid=3"
}

pkg_postrm() {
	gnome2_icon_cache_update
}
