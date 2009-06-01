# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-server/gtk-server-2.0.12.ebuild,v 1.3 2009/06/01 13:23:59 fmccor Exp $

inherit eutils

DESCRIPTION="GTK-server provides a stream-oriented interface to the GTK+ widget set"
HOMEPAGE="http://www.turtle.dds.nl/gtk-server/index.html"
SRC_URI="mirror://sourceforge/gtk-server/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-2*
	virtual/libffi"
DEPEND=">=sys-devel/autoconf-2.60
	${RDEPEND}"

src_compile() {
	sed -i -e "s,-lffi,-L/usr/$(get_libdir)/libffi -lffi,g" configure.in
	sed -i -e 's,-DLOCALCFG=\\".*\\",-DLOCALCFG=\\"/etc/gtk-server.cfg\\",g' \
		-e "s,@CFLAGS@,@CFLAGS@ ${CFLAGS},g" Makefile.in
	WANT_AUTOCONF=2.5 autoconf || die
	econf --with-gtk2 || die
	emake || die
}

src_install() {
	dobin gtk-server
	doman {gtk-server,gtk-server.cfg}.1
	dodoc README CREDITS
	insinto /etc
	doins gtk-server.cfg
	dohtml docs/*
	insinto /usr/share/doc/${PF}/demo
	doins demo/*
}
