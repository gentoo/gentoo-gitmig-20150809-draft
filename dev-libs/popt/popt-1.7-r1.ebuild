# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.7-r1.ebuild,v 1.18 2004/11/12 15:45:59 vapier Exp $

inherit libtool gnuconfig eutils

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://www.rpm.org/"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-uclibc.patch"
	cd ${S}
	gnuconfig_update
	elibtoolize
	use nls || touch ../rpm.c
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc CHANGES README
}
