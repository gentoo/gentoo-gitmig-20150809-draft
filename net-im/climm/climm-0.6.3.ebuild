# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/climm/climm-0.6.3.ebuild,v 1.2 2009/02/01 17:18:54 jokey Exp $

DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.climm.org/"
SRC_URI="http://www.climm.org/source/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gloox gnutls otr tcl ssl"

DEPEND="gloox? ( net-libs/gloox )
	gnutls? ( >=net-libs/gnutls-0.8.10 )
	ssl? (
		|| ( gnutls? ( >=net-libs/gnutls-0.8.10 )
		dev-libs/openssl ) )
	tcl? ( dev-lang/tcl )
	otr? ( >=net-libs/libotr-3.0.0 )"

pkg_setup() {
	if use gloox && ! use ssl ; then
		eerror "You need to set the ssl flag when you want to use the gloox"
		eerror "Jabber library"
		die "Set ssl or unset gloox for ${PN}"
	fi
}

src_compile() {
	local myconf
	if use ssl ; then
		if ! use gnutls ; then
			elog "Using openSSL"
			myconf="--enable-ssl=openssl"
		else
			elog "Using gnutls"
			myconf="--enable-ssl=gnutls"
		fi
	else
		myconf="--disable-ssl"
	fi

	econf \
		$(use_enable gloox) \
		$(use_enable otr) \
		$(use_enable ssl) \
		$(use_enable tcl) \
		${myconf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README TODO
}
