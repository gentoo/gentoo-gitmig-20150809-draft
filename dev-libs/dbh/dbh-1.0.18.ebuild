# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbh/dbh-1.0.18.ebuild,v 1.1 2004/04/18 05:08:16 bcowan Exp $

IUSE=""
MY_P="${PN}_1.0-18"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Disk based hashes is a method to create multidimensional binary trees on disk"
HOMEPAGE="http://dbh.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~ppc ~sparc ~alpha ~amd64 ~hppa ~mips"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
