# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbh/dbh-1.0.14.ebuild,v 1.1 2003/06/13 18:44:39 bcowan Exp $

IUSE=""
MY_P="${PN}_1.0-14"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Disk based hashes is a method to create multidimensional binary trees on disk"
HOMEPAGE="http://www.xfce.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO	
}
