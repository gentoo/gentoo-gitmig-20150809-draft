# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover-data/discover-data-2.2003.02.05.ebuild,v 1.10 2005/03/09 00:50:12 vapier Exp $

DESCRIPTION="data for discover. list of pci ids. pnp ids etc."
HOMEPAGE="http://componentizedlinux.org/discover/"
SRC_URI="http://archive.progeny.com/progeny/discover/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc -sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make prefix=/usr DESTDIR=${D} install || die
}
