# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbh/dbh-1.0.22.ebuild,v 1.2 2006/12/02 09:12:10 dev-zero Exp $

DESCRIPTION="Disk based hashes is a method to create multidimensional binary trees on disk"
HOMEPAGE="http://dbh.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL README ChangeLog
}
