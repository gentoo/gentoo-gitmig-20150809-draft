# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/perltrash/perltrash-0.3.ebuild,v 1.3 2003/03/11 21:11:44 seemant Exp $

DESCRIPTION="Command-line trash can emulation"
HOMEPAGE="http://www.iq-computing.de/perltrash"
SRC_URI="ftp://www.iq-computing.de/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND=">=dev-lang/perl-5"

src_install() {
	newbin perltrash.pl perltrash
	dodoc COPYING.txt README.txt
}
