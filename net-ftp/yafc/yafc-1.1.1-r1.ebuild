# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-1.1.1-r1.ebuild,v 1.9 2010/08/05 17:11:33 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Console ftp client with a lot of nifty features"
HOMEPAGE="http://yafc.sourceforge.net/"
SRC_URI="mirror://sourceforge/yafc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="readline kerberos socks5"

DEPEND="readline? ( >=sys-libs/readline-6 )
	kerberos? ( virtual/krb5 )
	socks5? ( net-proxy/dante )"
RDEPEND="${DEPEND}
	>=net-misc/openssh-3"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-heimdal_gssapi_fix.patch

	AT_M4DIR="cf" eautoreconf
}

src_configure() {
	local myconf=""

	if use kerberos; then
		if has_version app-crypt/heimdal; then
			myconf="${myconf} --with-krb5=/usr/ --with-krb4=no --with-gssapi=/usr"
		elif has_version app-crypt/mit-krb5; then
			myconf="${myconf} --with-krb5=/usr/ --with-krb4=no --with-gssapi=/usr"
		else
			ewarn "No supported kerberos providers detected"
			myconf="${myconf} --without-krb4 --without-krb5"
		fi
	fi

	use socks5 && myconf="${myconf} --with-socks5=/usr" \
		|| myconf="${myconf} --with-socks5=no"

	use readline && myconf="${myconf} --with-readline=/usr" \
		|| myconf="${myconf} --with-readline=no"

	econf \
		$(use_with readline) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUGS NEWS README THANKS TODO *.sample
}
