# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fluxbox-styles-fluxmod/fluxbox-styles-fluxmod-20041024.ebuild,v 1.8 2009/02/05 06:07:31 darkside Exp $

inherit eutils

DESCRIPTION="A collection of FluxBox themes from FluxMod"
HOMEPAGE="http://tenr.de/styles/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 sparc ~mips ppc ~alpha ~hppa ~amd64 ~ia64 ppc64"

IUSE=""
DEPEND=">=sys-apps/sed-4"
RDEPEND=">=x11-wm/fluxbox-0.9.10-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	# comment out every rootcommand
	find . -name '*.cfg' -exec \
		sed -i "{}" -e 's-^\(rootcommand\)-!!! \1-i' \;
}

src_install() {
	cd ${S}
	for d in * ; do
		insinto /usr/share/fluxbox/fluxmod/styles/${d}
		cp -R ${d}/* ${D}/usr/share/fluxbox/fluxmod/styles/${d}/
	done
	insinto /usr/share/fluxbox/menu.d/styles
	doins ${FILESDIR}/styles-menu-fluxmod
}

pkg_postinst() {
	einfo
	einfo "These styles are installed into /usr/share/fluxbox/fluxmod/. The"
	einfo "best way to use these styles is to ensure that you are running"
	einfo "fluxbox 0.9.10-r3 or later, and then to place the following in"
	einfo "your menu file:"
	einfo
	einfo "    [submenu] (Styles) {Select a Style}"
	einfo "        [include] (/usr/share/fluxbox/menu.d/styles/)"
	einfo "    [end]"
	einfo
	einfo "If you use fluxbox-generate_menu or the default global fluxbox"
	einfo "menu file, this will already be present."
	einfo
	epause
}
