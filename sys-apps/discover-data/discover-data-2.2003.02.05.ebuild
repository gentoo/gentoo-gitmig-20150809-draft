# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover-data/discover-data-2.2003.02.05.ebuild,v 1.1 2004/02/08 20:08:22 vapier Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://hackers.progeny.com/discover/"
SRC_URI="http://archive.progeny.com/progeny/discover/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"
IUSE="X gnome"

DEPEND="virtual/glibc"

src_install() {
	make prefix=/usr DESTDIR=${D} install || die
}
