# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/perltrash/perltrash-0.1.ebuild,v 1.2 2002/11/30 15:50:32 cybersystem Exp $

DESCRIPTION="Command-line trash can emulation"
HOMEPAGE="http://www.iq-computing.de/perltrash"
SRC_URI="ftp://www.iq-computing.de/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND=">=sys-devel/perl-5"

src_install() {
	newbin perltrash.pl perltrash
	dodoc COPYING.txt README.txt
}
