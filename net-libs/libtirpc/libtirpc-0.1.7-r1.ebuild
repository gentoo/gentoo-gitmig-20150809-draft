# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtirpc/libtirpc-0.1.7-r1.ebuild,v 1.1 2008/05/11 14:31:07 vapier Exp $

DESCRIPTION="Transport Independent RPC library (SunRPC replacement)"
HOMEPAGE="http://libtirpc.sourceforge.net/"
SRC_URI="http://nfsv4.bullopensource.org/tarballs/tirpc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-CVE-2007-3999.patch #214208
	sed -i \
		-e 's:/etc/netconfig:$(DESTDIR)/etc/netconfig:' \
		Makefile.in
	emake -s distclean || die
}

src_compile() {
	# gss stuff needs updating to latest API
	econf --disable-gss || die
	emake || die
}

src_install() {
	dodir /etc
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
