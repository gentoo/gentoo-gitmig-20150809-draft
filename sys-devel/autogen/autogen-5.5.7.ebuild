# Copyright 2004-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autogen/autogen-5.5.7.ebuild,v 1.1 2004/12/08 20:21:58 agriffis Exp $

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="dev-util/guile"

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
