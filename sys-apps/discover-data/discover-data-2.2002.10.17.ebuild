# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover-data/discover-data-2.2002.10.17.ebuild,v 1.2 2003/09/18 00:57:17 seemant Exp $

IUSE="X gnome"

S=${WORKDIR}/${P/7/8}
DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://hackers.progeny.com/discover/"
SRC_URI="http://archive.progeny.com/progeny/discover/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="virtual/glibc"

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	make prefix=/usr DESTDIR=${D} install || die
}
