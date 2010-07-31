# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed/sylpheed-3.0.3.ebuild,v 1.1 2010/07/31 07:44:22 hattya Exp $

EAPI="2"

inherit autotools eutils

IUSE="crypt ipv6 ldap nls pda spell ssl xface"

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.sraoss.jp/"
SRC_URI="http://sylpheed.sraoss.jp/${PN}/v${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"

COMMON_DEPEND=">=x11-libs/gtk+-2.4
	nls? ( >=sys-devel/gettext-0.12.1 )
	crypt? ( >=app-crypt/gpgme-1 )
	ldap? ( net-nds/openldap )
	pda? ( app-pda/jpilot )
	spell? ( app-text/gtkspell )
	ssl? ( dev-libs/openssl )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	xface? ( >=media-libs/compface-1.4 )"
RDEPEND="${COMMON_DEPEND}
	app-misc/mime-types
	net-misc/curl
	x11-misc/shared-mime-info"

AT_M4DIR="ac"

src_prepare() {

	epatch "${FILESDIR}"/${PN}-2.7-*.diff
	epatch "${FILESDIR}"/${PN}-3.*.diff

	use crypt || cp ac/missing/gpgme.m4 ac

	eautoreconf

}

src_configure() {

	local htmldir=/usr/share/doc/${PF}/html

	econf \
		$(use_enable crypt gpgme) \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable pda jpilot) \
		$(use_enable spell gtkspell) \
		$(use_enable ssl) \
		$(use_enable xface compface) \
		--with-manualdir=${htmldir}/manual \
		--with-faqdir=${htmldir}/faq \
		--disable-updatecheck \
		|| die

}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog* NEWS* README* TODO*
	doicon *.png
	domenu *.desktop

}
