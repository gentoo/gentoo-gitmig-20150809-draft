# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-dubya/fortune-mod-dubya-20040818.ebuild,v 1.2 2005/01/18 21:28:09 rizzo Exp $

DESCRIPTION="Quotes from George W. Bush"
HOMEPAGE="http://dubya.seiler.us/"
SRC_URI="http://dubya.seiler.us/files/dubya-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${PN/fortune-mod-/}"

src_install() {
	insinto /usr/share/fortune
	doins dubya dubya.dat
}
