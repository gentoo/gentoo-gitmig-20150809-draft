# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/stow/stow-1.3.3.ebuild,v 1.15 2003/07/01 20:30:06 aliz Exp $

DESCRIPTION="manage installation of software in /usr/local"
SRC_URI="mirror://gnu/stow/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/${PN}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="dev-lang/perl"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
