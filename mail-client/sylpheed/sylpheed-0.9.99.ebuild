# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed/sylpheed-0.9.99.ebuild,v 1.2 2004/11/18 13:40:44 hattya Exp $

inherit eutils

IUSE="crypt gnome imlib ipv6 ldap nls pda ssl"

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.good-day.net/"
SRC_URI="http://sylpheed.good-day.net/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64"
SLOT="0"

PROVIDE="virtual/sylpheed"

DEPEND="=x11-libs/gtk+-1.2*
	!amd64? ( nls? ( >=sys-devel/gettext-0.12.1 ) )
	>=media-libs/compface-1.4
	ssl? ( dev-libs/openssl )
	pda? ( app-pda/jpilot )
	ldap? ( >=net-nds/openldap-2.0.11 )
	crypt? ( =app-crypt/gpgme-0.3.14-r1 )
	gnome? ( media-libs/gdk-pixbuf )
	imlib? ( media-libs/imlib )"
RDEPEND="${DEPEND}
	app-misc/mime-types
	x11-misc/shared-mime-info"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-namespace.diff
	epatch ${FILESDIR}/${PN}-procmime.diff

}

src_compile() {

	use crypt && export GPGME_CONFIG="${ROOT}usr/bin/gpgme3-config"

	econf \
		`use_enable nls` \
		`use_enable ssl` \
		`use_enable crypt gpgme` \
		`use_enable pda jpilot` \
		`use_enable ldap` \
		`use_enable ipv6` \
		`use_enable imlib` \
		`use_enable gnome gdk-pixbuf` \
		--enable-compface \
		|| die

	emake || die

}

src_install() {

	einstall

	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins *.png

	if use gnome
	then
		dodir /usr/share/gnome/apps/Internet
		insinto /usr/share/gnome/apps/Internet
		doins sylpheed.desktop
	fi

	dodoc [A-Z][A-Z]* ChangeLog*

}
