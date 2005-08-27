# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-strangelove/fortune-mod-strangelove-20041203.ebuild,v 1.4 2005/08/27 18:09:00 corsair Exp $

DESCRIPTION="Quotes from Dr. Strangelove"
HOMEPAGE="http://seiler.us/wiki/index.php/Strangelove"
SRC_URI="http://seiler.us/wiki/images/4/48/Strangelove_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${PN/fortune-mod-/}"

src_install() {
	insinto /usr/share/fortune
	doins strangelove strangelove.dat
}
