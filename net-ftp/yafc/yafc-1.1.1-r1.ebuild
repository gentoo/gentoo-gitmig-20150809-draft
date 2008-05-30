# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-1.1.1-r1.ebuild,v 1.8 2008/05/30 04:50:23 darkside Exp $

inherit autotools eutils

DESCRIPTION="Console ftp client with a lot of nifty features"
HOMEPAGE="http://yafc.sourceforge.net/"
SRC_URI="mirror://sourceforge/yafc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
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
	epatch "${FILESDIR}/${P}-heimdal_gssapi_fix.patch"

	AT_M4DIR="cf"
	eautoreconf
}

src_compile() {
	local myconf=""
	if use kerberos ; then
		if has_version app-crypt/heimdal ; then
			myconf="${myconf} --with-krb5=/usr/ --with-krb4=no --with-gssapi=/usr"
		elif has_version app-crypt/mit-krb5 ; then
			if built_with_use app-crypt/mit-krb5 krb4 ; then
				myconf="${myconf} --with-krb5=/usr/ --with-krb4=/usr/ --with-gssapi=/usr"
			else
				myconf="${myconf} --with-krb5=/usr/ --with-krb4=no --with-gssapi=/usr"
			fi
		else
			die "No supported kerberos provider detected"
		fi
	else
		myconf="${myconf} --without-krb4 --without-krb5"
	fi
#	use kerberos && myconf="${myconf} --with-krb5=/usr/ --with-gssapi=/usr" \
#		|| myconf="${myconf} --with-krb5=no --with-krb4=no --with-gssapi=no"
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
