# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/patchutils/patchutils-0.2.23.ebuild,v 1.4 2003/12/29 03:22:22 kumba Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A collection of tools that operate on patch files"
HOMEPAGE="http://cyberelk.net/tim/patchutils/"
SRC_URI="http://cyberelk.net/tim/data/patchutils/stable/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha mips hppa ~arm"

DEPEND="virtual/glibc"

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
}
