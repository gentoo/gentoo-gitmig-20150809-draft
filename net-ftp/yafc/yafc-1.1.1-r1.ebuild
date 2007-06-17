# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-1.1.1-r1.ebuild,v 1.4 2007/06/17 14:44:11 armin76 Exp $

inherit eutils

DESCRIPTION="Console ftp client with a lot of nifty features"
HOMEPAGE="http://yafc.sourceforge.net/"
SRC_URI="mirror://sourceforge/yafc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="readline kerberos socks5"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )
	kerberos? ( virtual/krb5 )
	socks5? ( net-proxy/dante )"
RDEPEND=">=net-misc/openssh-3.0
	${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	local myconf=""
	use kerberos && myconf="${myconf} --with-krb5=/usr/ --with-gssapi=/usr" \
		|| myconf="${myconf} --with-krb5=no --with-gssapi=no"
	use socks5 && myconf="${myconf} --with-socks5=/usr" \
		|| myconf="${myconf} --with-socks5=no"
	use readline && myconf="${myconf} --with-readline=/usr" \
		|| myconf="${myconf} --with-readline=no"

	econf $(use_with readline) ${myconf} || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc BUGS NEWS README THANKS TODO *.sample
}
