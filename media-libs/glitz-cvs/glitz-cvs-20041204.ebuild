# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glitz-cvs/glitz-cvs-20041204.ebuild,v 1.1 2004/12/05 16:14:51 twp Exp $

inherit eutils

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#SRC_URI="http://dev.gentoo.org/~twp/distfiles/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/opengl"
S=${WORKDIR}/${P}

src_compile() {
	./autogen.sh --prefix=/usr \
				 --host=${CHOST} \
				 --mandir=/usr/share/man \
				 --infodir=/usr/share/info \
				 --datadir=/usr/share \
				 --sysconfdir=/etc \
				 --localstatedir=/var/lib || die "autogen.sh failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
