# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.7-r1.ebuild,v 1.3 2003/03/28 06:27:42 seemant Exp $

inherit libtool

DESCRIPTION="Parse Options - Command line parser"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa arm"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	elibtoolize
	local myconf="--with-gnu-ld"
	use nls || ( \
		myconf="${myconf} --disable-nls"
		touch ../rpm.c
	)
	econf ${myconf} || die
	make || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS CHANGES README
}
