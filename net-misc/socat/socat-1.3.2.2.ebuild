# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/socat/socat-1.3.2.2.ebuild,v 1.2 2004/06/08 07:46:29 kloeri Exp $

DESCRIPTION="Multipurpose relay (SOcket CAT)"
HOMEPAGE="http://www.dest-unreach.org/socat/"
SRC_URI="http://www.dest-unreach.org/${PN}/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips alpha ~hppa ~amd64"
IUSE="ssl readline ipv6"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
	virtual/glibc"
RDEPEND="virtual/glibc"

S=${WORKDIR}/socat-${PV:0:3}

src_compile() {
	econf \
		`use_enable ssl openssl` \
		`use_enable readline` \
		`use_enable ipv6 ip6` \
		|| die "econf failed"
	emake || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make install DESTDIR=${D} || die

	dodoc BUGREPORTS CHANGES DEVELOPMENT EXAMPLES \
		FAQ FILES PORTING README SECURITY VERSION xio.help
	docinto examples
	dodoc *.sh
	dohtml socat.html
}
