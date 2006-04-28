# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed/sylpheed-2.2.4.ebuild,v 1.2 2006/04/28 14:14:50 hattya Exp $

inherit eutils

IUSE="crypt gnome ipv6 ldap nls pda spell ssl xface"

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.good-day.net/"
SRC_URI="http://sylpheed.good-day.net/${PN}/v${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 ~sparc x86"
SLOT="0"

PROVIDE="virtual/sylpheed"

DEPEND=">=x11-libs/gtk+-2.4
	nls? ( >=sys-devel/gettext-0.12.1 )
	crypt? ( >=app-crypt/gpgme-0.4.5 )
	ldap? ( >=net-nds/openldap-2.0.11 )
	pda? ( app-pda/jpilot )
	spell? ( app-text/gtkspell )
	ssl? ( dev-libs/openssl )
	xface? ( >=media-libs/compface-1.4 )"
RDEPEND="${DEPEND}
	app-misc/mime-types
	x11-misc/shared-mime-info"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-2.*.diff
	automake

}

src_compile() {

	econf \
		`use_enable crypt gpgme` \
		`use_enable ipv6` \
		`use_enable ldap` \
		`use_enable nls` \
		`use_enable pda jpilot` \
		`use_enable spell gtkspell` \
		`use_enable ssl` \
		`use_enable xface compface` \
		|| die

	emake || die

}

src_install() {

	einstall

	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins *.png

	insinto /usr/share/applications
	doins sylpheed.desktop

	dodoc AUTHORS COPYING ChangeLog* INSTALL* NEWS* README* TODO*

}
