# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbh/dbh-1.0.19.ebuild,v 1.4 2005/01/21 23:19:08 kloeri Exp $

IUSE=""
MY_P="${PN}_1.0-19"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Disk based hashes is a method to create multidimensional binary trees on disk"
HOMEPAGE="http://dbh.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL COPYING README ChangeLog
}
