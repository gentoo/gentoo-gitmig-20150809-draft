# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.7-r1.ebuild,v 1.10 2004/04/26 01:15:47 vapier Exp $

inherit libtool gnuconfig

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://www.rpm.org/"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	gnuconfig_update
	elibtoolize

	use nls || touch ../rpm.c

	econf `use_enable nls` || die
	make || die
}

src_install() {
	einstall || die
	dodoc CHANGES README
}
