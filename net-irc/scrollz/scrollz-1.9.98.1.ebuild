# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/scrollz/scrollz-1.9.98.1.ebuild,v 1.1 2006/10/26 18:53:13 jokey Exp $

inherit eutils

MY_P=ScrollZ-${PV}

DESCRIPTION="Advanced IRC client based on ircII"
SRC_URI="ftp://ftp.du.se/pub/mirrors/ScrollZ/source/${MY_P}.tar.gz"
HOMEPAGE="http://www.scrollz.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc-macos ~x86"
IUSE="ipv6 socks5 ssl gnutls"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )
	gnutls? ( net-libs/gnutls )"
S="${WORKDIR}"/${MY_P}

src_compile() {
	econf \
		--with-default-server=irc.freenode.net \
		$(use_enable ipv6) \
		$(use_enable socks5) \
		$(use_with ssl) \
		$(use_with gnutls) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/man/man1
	einstall \
		sharedir="${D}"/usr/share \
		mandir="${D}"/usr/share/man/man1 \
		install \
		|| die "einstall failed"
	dodoc ChangeLog* README* || die "dodoc failed"

	# fix erms of manpage
	fperms 644 /usr/share/man/man1/scrollz.1
}
