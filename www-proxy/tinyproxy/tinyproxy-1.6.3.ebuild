# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/tinyproxy/tinyproxy-1.6.3.ebuild,v 1.2 2005/04/06 18:50:19 mrness Exp $

DESCRIPTION="A lightweight HTTP/SSL proxy"
HOMEPAGE="http://tinyproxy.sourceforge.net/"
SRC_URI="mirror://sourceforge/tinyproxy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="socks5 transparent-proxy debug"

DEPEND="socks5? ( net-misc/dante )"

src_compile() {
	econf \
		--enable-xtinyproxy \
		--enable-filter \
		--enable-tunnel \
		--enable-upstream \
		`use_enable transparent-proxy` \
		`use_enable debug` \
		`use_enable debug profiling` \
		`use_enable socks5 socks` \
		|| die
	emake || die "emake failed"
}

src_install() {
	sed -i \
		's:mkdir $(datadir)/tinyproxy:mkdir -p $(DESTDIR)$(datadir)/tinyproxy:' \
		Makefile
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
	mv ${D}/usr/share/tinyproxy ${D}/usr/share/doc/${PF}/html

	exeinto /etc/init.d
	newexe ${FILESDIR}/tinyproxy.rc tinyproxy
}
