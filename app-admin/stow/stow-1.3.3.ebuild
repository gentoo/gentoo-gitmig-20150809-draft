# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/stow/stow-1.3.3.ebuild,v 1.4 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Stow -- manage installation of software in /usr/local"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/stow/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.gnu.org/software/${PN}/"
LICENSE="GPL-2"

DEPEND=">=sys-devel/perl-5.005"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
