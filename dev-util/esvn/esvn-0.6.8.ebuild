# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/esvn/esvn-0.6.8.ebuild,v 1.1 2005/01/24 23:45:31 mrness Exp $

inherit kde-functions
need-qt 3

MY_P="${P}-1"
DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://esvn.umputun.com/"
SRC_URI="http://esvn.umputun.com/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="${RDEPEND}
	dev-util/subversion"

S="${WORKDIR}/${PN}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make -f esvn.mak INSTALL_ROOT=${D} install
	dobin esvn-diff-wrapper

	dodoc AUTHORS ChangeLog COPYING LICENSE README
}
