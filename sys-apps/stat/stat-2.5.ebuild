# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/stat/stat-2.5.ebuild,v 1.3 2002/07/14 19:20:19 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A command-line stat() wrapper."
SRC_URI="ftp://metalab.unc.edu/pub/linux/utils/file/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/stat.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2 -g:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin stat
	doman stat.1
	dodoc COPYRIGHT GPL README Changelog
}
