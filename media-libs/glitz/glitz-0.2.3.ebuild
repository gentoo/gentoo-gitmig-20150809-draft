# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glitz/glitz-0.2.3.ebuild,v 1.2 2004/12/20 13:01:20 twp Exp $

inherit eutils

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#SRC_URI="http://dev.gentoo.org/~twp/distfiles/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/opengl"

src_compile() {
	WANT_AUTOMAKE=1.8 ./autogen.sh --prefix=/usr \
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
