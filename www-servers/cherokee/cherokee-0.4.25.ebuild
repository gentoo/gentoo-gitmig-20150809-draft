# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.4.25.ebuild,v 1.2 2005/08/05 17:12:33 ka0ttic Exp $

inherit eutils

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="http://www.0x50.org/download/${PV%.*}/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.0x50.org/"
LICENSE="GPL-2"

RDEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4-r1"

DEPEND=">=sys-devel/automake-1.7.5
	gnutls? ( net-libs/gnutls )
	ssl? ( dev-libs/openssl )
	${RDEPEND}"

KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"
IUSE="ipv6 ssl gnutls static"

src_compile() {
	local myconf

	if use ssl && use gnutls ; then
		myconf="${myconf} --enable-ssl=gnutls"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf}  --enable-ssl=openssl"
	else
		myconf="${myconf} --disable-ssl"
	fi
	if ! use ipv6 ; then
		myconf="${myconf} --disable-ipv6"
	fi
	if use static ; then
		myconf="${myconf} --enable-static --enable-static-module=all --disble-shared"
	else
		myconf="${myconf} --disable-static"
	fi

	econf \
		${myconf} \
		--enable-os-string="Gentoo Linux" \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install () {
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin

	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL README

	newinitd ${FILESDIR}/${PN}-0.4.17-init.d ${PN} || die "newinitd failed"
}
