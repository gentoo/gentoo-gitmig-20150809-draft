# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.5.ebuild,v 1.12 2002/10/05 05:39:11 drobbins Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Parse Options: command line parser"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-3.0.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING README
}
