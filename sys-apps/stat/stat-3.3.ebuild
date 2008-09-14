# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/stat/stat-3.3.ebuild,v 1.8 2008/09/14 09:05:33 solar Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A command-line stat() wrapper"
SRC_URI="ftp://metalab.unc.edu/pub/linux/utils/file/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/stat.html"

KEYWORDS="~arm amd64 sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp Makefile Makefile.orig
	sed -e "s:-O2 -g:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	tc-export CC
	emake CC="${CC}" || die
}

src_install() {
	dobin stat
	doman stat.1
	dodoc COPYRIGHT GPL README Changelog
}
