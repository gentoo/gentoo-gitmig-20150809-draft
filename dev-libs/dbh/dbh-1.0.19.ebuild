# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbh/dbh-1.0.19.ebuild,v 1.2 2004/09/18 15:34:07 tgall Exp $

IUSE=""
MY_P="${PN}_1.0-19"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Disk based hashes is a method to create multidimensional binary trees on disk"
HOMEPAGE="http://dbh.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~ppc ~sparc ~alpha ~amd64 ~hppa ~mips ppc64"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL COPYING README ChangeLog
}
