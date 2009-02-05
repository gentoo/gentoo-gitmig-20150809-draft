# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fluxbox-styles-fluxmod/fluxbox-styles-fluxmod-20040809.ebuild,v 1.7 2009/02/05 06:07:31 darkside Exp $

DESCRIPTION="A collection of FluxBox themes from FluxMod"
HOMEPAGE="http://tenr.de/styles/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 sparc mips ppc ~alpha ~hppa ~amd64 ~ia64 ~ppc64"

IUSE=""
DEPEND=">=sys-apps/sed-4"
RDEPEND=">=x11-wm/fluxbox-0.9.8"

src_unpack() {
	unpack ${A}
	cd ${S}
	# comment out every rootcommand
	find . -name '*.cfg' -exec \
		sed -i "{}" -e 's-^\(rootcommand\)-!!! \1-i' \;
}

src_install() {
	cd ${S}
	for d in styles ; do
		insinto /usr/share/fluxbox/${d}
		cp -R ${d}/* ${D}/usr/share/fluxbox/${d}/
	done
}

pkg_postinst() {
	einfo
	einfo "These styles are installed into /usr/share/fluxbox, which will"
	einfo "show up in Fluxbox Menu > System Styles by default. You will have"
	einfo "to either restart Fluxbox or use Fluxbox Menu > Reload config"
	einfo "for changes to show up."
	einfo
}
