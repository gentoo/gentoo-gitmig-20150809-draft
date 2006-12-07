# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/openbox-themes/openbox-themes-0.6-r1.ebuild,v 1.5 2006/12/07 02:05:19 flameeyes Exp $

DESCRIPTION="A set of themes for Openbox3."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://gumerry.co.uk/themes/"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE="gtk"
SLOT="0"

RDEPEND=">=x11-wm/openbox-3.0_beta6
		gtk? (
			|| (
				>=x11-themes/gtk-engines-2.6
				x11-themes/gnome-themes
			)
		)"

src_install() {
	dodir /usr/share/themes
	cp -pPR ${S}/* ${D}/usr/share/themes
}
