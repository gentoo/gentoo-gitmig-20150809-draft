# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hotkeys/hotkeys-0.5.5.ebuild,v 1.7 2002/12/15 00:56:45 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Make use of extra buttons on newer keyboards."
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${P}.tar.bz2"
HOMEPAGE="http://ypwong.org/hotkeys/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	dev-libs/libxml2
	>=sys-libs/db-3.2.9
	~x11-libs/xosd-0.7.0"


src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	econf \
		--with-xosd-lib=/usr/lib/xosd-0.7.0 \
		--with-xosd-inc=/usr/include/xosd-0.7.0 \
		|| die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING README TODO
}
