# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.6.3.ebuild,v 1.7 2002/08/14 11:52:28 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Parse Options - Command line parser"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"
	
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING README
}
