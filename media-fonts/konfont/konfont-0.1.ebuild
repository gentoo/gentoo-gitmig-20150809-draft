# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/konfont/konfont-0.1.ebuild,v 1.4 2004/07/29 19:13:38 kugelfang Exp $

IUSE=""

MY_P="${P/-/_}.orig"

DESCRIPTION="Fontset for KON2"
SRC_URI="mirror://debian/dists/potato/main/source/utils/${MY_P}.tar.gz"
HOMEPAGE=""
LICENSE="as-is"
SLOT=0
KEYWORDS="x86 ~amd64"

DEPEND="virtual/libc"

S="${WORKDIR}/${MY_P/_/-}/fonts"

src_install(){

	insinto /usr/share/fonts

	doins pubfont.*.gz || die
}
