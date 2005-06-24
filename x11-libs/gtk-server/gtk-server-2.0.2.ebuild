# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-server/gtk-server-2.0.2.ebuild,v 1.3 2005/06/24 13:14:15 dholm Exp $

inherit eutils

DESCRIPTION="GTK-server provides a stream-oriented interface to the GTK+ widget set"
HOMEPAGE="http://www.turtle.dds.nl/gtk-server/index.html"
SRC_URI="mirror://sourceforge/gtk-server/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="gtk2"

DEPEND="gtk2? ( =x11-libs/gtk+-2* )
	!gtk2? ( =x11-libs/gtk+-1* )
	dev-libs/libffi"

src_compile() {
	local myconf=""
	if use gtk2; then myconf="--with-gtk2"; else myconf="--with-gtk1"; fi
	sed -i -e 's,-DLOCALCFG=\\".*\\",-DLOCALCFG=\\"/etc/gtk-server.cfg\\",g' \
		-e "s,@CFLAGS@,@CFLAGS@ ${CFLAGS},g" Makefile.in
	econf ${myconf} || die
	emake || die
}

src_install() {
	dobin gtk-server
	doman {gtk-server,gtk-server.cfg}.1
	dodoc README CREDITS
	insinto /etc
	doins gtk-server.cfg
	dohtml docs/*
}
