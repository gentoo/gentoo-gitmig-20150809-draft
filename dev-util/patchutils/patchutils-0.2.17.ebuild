# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/patchutils/patchutils-0.2.17.ebuild,v 1.2 2002/12/09 04:21:16 manson Exp $

DESCRIPTION="A collection of tools that operate on patch files"
HOMEPAGE="http://cyberelk.net/tim/patchutils/"
SRC_URI="http://cyberelk.net/tim/data/patchutils/stable/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc "
DEPEND="virtual/glibc"
S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
