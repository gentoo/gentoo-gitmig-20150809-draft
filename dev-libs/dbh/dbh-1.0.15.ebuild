# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbh/dbh-1.0.15.ebuild,v 1.12 2005/01/21 23:19:08 kloeri Exp $

IUSE=""
MY_P="${PN}_1.0-15"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Disk based hashes is a method to create multidimensional binary trees on disk"
HOMEPAGE="http://www.xfce.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64 x86 ppc sparc alpha amd64 hppa ~mips"

DEPEND="dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
