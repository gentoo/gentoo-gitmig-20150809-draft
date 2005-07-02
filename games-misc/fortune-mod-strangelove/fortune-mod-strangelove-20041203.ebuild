# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-strangelove/fortune-mod-strangelove-20041203.ebuild,v 1.2 2005/07/02 19:35:15 rizzo Exp $

DESCRIPTION="Quotes from Dr. Strangelove"
HOMEPAGE="http://seiler.us/wiki/index.php/Strangelove"
SRC_URI="http://seiler.us/wiki/images/4/48/Strangelove_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${PN/fortune-mod-/}"

src_install() {
	insinto /usr/share/fortune
	doins strangelove strangelove.dat
}
