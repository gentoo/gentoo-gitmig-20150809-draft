# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ossh/ossh-1.5.12.ebuild,v 1.3 2004/11/06 16:14:54 pyrania Exp $

inherit gnuconfig flag-o-matic

DESCRIPTION="another SSH implementation"
HOMEPAGE="ftp://ftp.pdc.kth.se/pub/krypto/ossh/"
SRC_URI="ftp://ftp.nada.kth.se/pub/krypto/ossh/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="zlib socks5"

DEPEND="!virtual/ssh
	zlib? ( sys-libs/zlib )
	socks5? ( net-misc/dante )
	dev-libs/gmp
	dev-libs/openssl"
PROVIDE="virtual/ssh"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	sed -i '/^LIBS/s:$: -lcrypto:' Makefile.in
	sed -i 's:des\.h:openssl/des.h:' cipher.h
}

src_compile() {
	append-flags -I${ROOT}/usr/include/openssl
	econf \
		`use_with socks5 socks` \
		`use_with zlib` \
		--with-etcdir=/etc/ossh \
		|| die
	emake || die
}

src_install() {
	dodir /usr/share /etc/ossh
	make \
		install_prefix=${D} \
		libexec=/usr/sbin \
		mandir=/usr/share/man \
		install || die
	dodoc ChangeLog OVERVIEW README TODO
}
