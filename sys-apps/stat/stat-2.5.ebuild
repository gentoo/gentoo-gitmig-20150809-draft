# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/stat/stat-2.5.ebuild,v 1.9 2003/04/25 16:06:01 vapier Exp $

inherit eutils

DESCRIPTION="A command-line stat() wrapper"
SRC_URI="ftp://metalab.unc.edu/pub/linux/utils/file/${P}.tar.gz
	 selinux? mirror://gentoo/${P}-selinux.patch.bz2"
HOMEPAGE="http://www.gnu.org/directory/stat.html"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="selinux"

DEPEND="virtual/glibc
	selinux? ( sys-apps/selinux-small )"

src_unpack() {
	unpack ${A}
	cd ${S}

	use selinux && epatch ${DISTDIR}/${P}-selinux.patch.bz2

	cp Makefile Makefile.orig
	sed -e "s:-O2 -g:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin stat
	doman stat.1
	dodoc COPYRIGHT GPL README Changelog
}
