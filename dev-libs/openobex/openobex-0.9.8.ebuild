# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Leigh Dyer <lsd@linuxgamers.net>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-0.9.8.ebuild,v 1.1 2002/05/15 07:40:41 george Exp $

S=${WORKDIR}/${P}

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/openobex/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/openobex"

LICENSE="GPL-2"

DEPEND=">=dev-libs/glib-1.2"
RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
