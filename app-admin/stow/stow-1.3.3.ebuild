# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/stow/stow-1.3.3.ebuild,v 1.5 2002/07/25 13:48:39 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Stow -- manage installation of software in /usr/local"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/stow/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/${PN}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-devel/perl"

src_compile() {
	econf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
