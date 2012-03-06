# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/greybird/greybird-0.5.ebuild,v 1.1 2012/03/06 18:13:33 ssuominen Exp $

EAPI=4

MY_PN=${PN/g/G}

DESCRIPTION="The default theme used in Xubuntu (with matching theme for GTK+-2 and GTK+-3)"
HOMEPAGE="http://shimmerproject.org/project/greybird/ http://github.com/shimmerproject/Greybird"
SRC_URI="http://github.com/shimmerproject/${MY_PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-themes/gtk-engines-murrine-0.90
	>=x11-themes/gtk-engines-unico-1.0.1"
DEPEND=""

RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_install() {
	dodoc README
	rm -f README LICENSE*

	insinto /usr/share/themes/${MY_PN}
	doins -r *
}
