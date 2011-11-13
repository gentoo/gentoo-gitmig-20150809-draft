# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/light-themes/light-themes-0.1.8.25.ebuild,v 1.1 2011/11/13 23:37:50 sping Exp $

EAPI="3"

DESCRIPTION="Ambiance and Radiance themes from Ubuntu"
HOMEPAGE="https://launchpad.net/light-themes"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3"

DEPEND=""
RDEPEND="x11-themes/gtk-engines-murrine
	gtk3? ( x11-themes/gtk-engines-unico )"

src_install() {
	insinto /usr/share/themes
	doins -r Radiance Ambiance || die
}
