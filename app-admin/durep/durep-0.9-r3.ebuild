# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/durep/durep-0.9-r3.ebuild,v 1.4 2012/06/08 11:42:36 phajdan.jr Exp $

EAPI=4
inherit eutils

DESCRIPTION="A perl script designed for monitoring disk usage in a more visual way than du."
HOMEPAGE="http://gentoo.org"
SRC_URI="http://www.hibernaculum.net/download/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/MLDBM"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gigabyte.patch
	epatch "${FILESDIR}"/${P}-color-output.patch
	epatch "${FILESDIR}"/${P}-dirhandle.patch
}

src_install() {
	dobin durep
	doman durep.1
	dodoc BUGS CHANGES README THANKS
	dohtml -A cgi *.cgi *.css *.png
}
