# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.7-r1.ebuild,v 1.8 2004/02/21 00:58:40 mr_bones_ Exp $

inherit libtool gnuconfig

IUSE="nls"

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://www.rpm.org/"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa ia64 ppc64"

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
