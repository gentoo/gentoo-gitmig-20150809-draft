# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-strangelove/fortune-mod-strangelove-20041203.ebuild,v 1.1 2004/12/03 16:33:48 rizzo Exp $

DESCRIPTION="Quotes from Dr. Strangelove"
HOMEPAGE="http://seiler.us/index.php?module=documents&JAS_DocumentManager_op=viewDocument&JAS_Document_id=2"
SRC_URI="http://seiler.us/files/documents/strangelove_${PV}.tar.gz"

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
