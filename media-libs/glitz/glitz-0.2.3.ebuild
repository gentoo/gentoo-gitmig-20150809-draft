# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glitz/glitz-0.2.3.ebuild,v 1.8 2006/12/01 18:44:45 gustavoz Exp $

inherit eutils

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#SRC_URI="http://dev.gentoo.org/~twp/distfiles/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="virtual/opengl"

src_compile() {
	epatch ${FILESDIR}/glitz-0.2.3-link.patch
	WANT_AUTOMAKE=1.8 ./autogen.sh --prefix=/usr \
								   --host=${CHOST} \
								   --mandir=/usr/share/man \
								   --infodir=/usr/share/info \
								   --datadir=/usr/share \
								   --sysconfdir=/etc \
								   --localstatedir=/var/lib \
								   ${EXTRA_ECONF} || die "autogen.sh failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
