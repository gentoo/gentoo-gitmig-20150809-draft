# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.7-r1.ebuild,v 1.4 2003/03/28 07:07:30 seemant Exp $

inherit libtool gnuconfig

IUSE="nls"

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://www.rpm.org/"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	gnuconfig_update
	elibtoolize

	if [ -z "`use nls`" ]
	then
		touch ../rpm.c
	fi

	econf `use_enable nls` --with-gnu-ld || die
	make || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS CHANGES README
}
