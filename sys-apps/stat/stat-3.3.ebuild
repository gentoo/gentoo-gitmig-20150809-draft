# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/stat/stat-3.3.ebuild,v 1.10 2008/11/27 18:40:38 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A command-line stat() wrapper"
HOMEPAGE="http://www.gnu.org/directory/stat.html"
SRC_URI="ftp://metalab.unc.edu/pub/linux/utils/file/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm sparc x86"
IUSE=""

DEPEND="!sys-apps/coreutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-O2 -g:${CFLAGS} ${CPPFLAGS}:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin stat || die
	doman stat.1
	dodoc COPYRIGHT README Changelog
}
