# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/patchutils/patchutils-0.2.23.ebuild,v 1.11 2005/02/07 00:27:08 kumba Exp $

DESCRIPTION="A collection of tools that operate on patch files"
HOMEPAGE="http://cyberelk.net/tim/patchutils/"
SRC_URI="http://cyberelk.net/tim/data/patchutils/stable/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
}
