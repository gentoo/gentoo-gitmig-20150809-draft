# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed/sylpheed-2.6.0.ebuild,v 1.13 2012/05/26 08:19:00 hattya Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.sraoss.jp/"
SRC_URI="http://sylpheed.sraoss.jp/${PN}/v${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="crypt ipv6 ldap nls pda spell ssl xface"

CDEPEND="x11-libs/gtk+:2
	nls? ( sys-devel/gettext )
	crypt? ( app-crypt/gpgme )
	ldap? ( net-nds/openldap )
	pda? ( app-pda/jpilot )
	spell? ( app-text/gtkspell:2 )
	ssl? ( dev-libs/openssl )"
RDEPEND="${CDEPEND}
	app-misc/mime-types
	x11-misc/shared-mime-info"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	xface? ( media-libs/compface )"

AT_M4DIR="ac"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.[145]-*.diff
	epatch "${FILESDIR}"/${PN}-r3033.diff
	use crypt || cp ac/missing/gpgme.m4 ac
	eautoreconf
}

src_configure() {
	local htmldir=/usr/share/doc/${PF}/html
	econf \
		$(use_enable crypt gpgme) \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable nls) \
		$(use_enable pda jpilot) \
		$(use_enable spell gtkspell) \
		$(use_enable ssl) \
		$(use_enable xface compface) \
		--with-manualdir=${htmldir}/manual \
		--with-faqdir=${htmldir}/faq
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog* NEWS* README* TODO*

	doicon *.png
	domenu *.desktop
}
