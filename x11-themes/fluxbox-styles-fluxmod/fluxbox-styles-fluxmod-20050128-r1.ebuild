# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fluxbox-styles-fluxmod/fluxbox-styles-fluxmod-20050128-r1.ebuild,v 1.4 2009/02/05 06:07:31 darkside Exp $

inherit eutils

DESCRIPTION="A collection of FluxBox themes from FluxMod"
HOMEPAGE="http://tenr.de/styles/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"

IUSE=""
DEPEND=">=sys-apps/sed-4"
RDEPEND=">=x11-wm/fluxbox-0.9.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	# comment out every rootcommand
	find . -name '*.cfg' -exec \
		sed -i "{}" -e 's-^\(rootcommand\)-!!! \1-i' \;
	# weird tarball...
	find . -exec chmod a+r '{}' \;
}

src_install() {
	cd ${S}
	mkdir -p ${D}/usr/share/fluxbox/fluxmod/styles/ || die "mkdir eeked"
	insinto /usr/share/fluxbox/fluxmod/styles
	doins -r * || die "doins failed"
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
	einfo "Note that some of these styles use the PNG image format. For"
	einfo "these to work, fluxbox must be built with USE=\"imlib\" and"
	einfo "imlib2 must be built with USE=\"png\"."
	einfo
	epause
}
