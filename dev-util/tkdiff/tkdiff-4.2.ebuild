# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tkdiff/tkdiff-4.2.ebuild,v 1.1 2011/12/11 21:30:41 ottxor Exp $

EAPI=4

DESCRIPTION="tkdiff is a graphical front end to the diff program"
HOMEPAGE="http://tkdiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-lang/tk-8.4.18-r1"

S="${WORKDIR}/${PN}-unix"

src_install() {
	dobin tkdiff
	dodoc CHANGELOG.txt
}
