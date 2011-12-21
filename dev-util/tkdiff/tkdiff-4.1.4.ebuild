# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tkdiff/tkdiff-4.1.4.ebuild,v 1.5 2011/12/21 05:41:03 xmw Exp $

inherit eutils

MY_P="${P}-unix"
DESCRIPTION="tkdiff is a graphical front end to the diff program"
HOMEPAGE="http://tkdiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/tkdiff/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-lang/tk-8.4.18-r1"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-hg.patch"
}

src_install() {
	dobin tkdiff
	dodoc Changelog
}
