# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed/sylpheed-0.9.11.ebuild,v 1.5 2004/07/31 02:14:22 tgall Exp $

inherit eutils

IUSE="ssl xface ipv6 imlib nls gnome ldap crypt pda"

DESCRIPTION="A lightweight email client and newsreader"
SRC_URI="http://sylpheed.good-day.net/${PN}/${P}.tar.bz2"
HOMEPAGE="http://sylpheed.good-day.net"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~ia64 ~amd64 ppc64"
SLOT="0"

PROVIDE="virtual/sylpheed"

DEPEND="=x11-libs/gtk+-1.2*
	!amd64? ( nls? ( =sys-devel/gettext-0.12.1* ) )
	ssl? ( dev-libs/openssl )
	pda? ( app-pda/jpilot )
	ldap? ( >=net-nds/openldap-2.0.11 )
	crypt? ( app-crypt/gnupg <app-crypt/gpgme-0.4 )
	gnome? ( media-libs/gdk-pixbuf )
	imlib? ( media-libs/imlib )
	xface? ( >=media-libs/compface-1.4 )"
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

	econf \
		`use_enable nls` \
		`use_enable ssl` \
		`use_enable crypt gpgme` \
		`use_enable pda jpilot` \
		`use_enable ldap` \
		`use_enable ipv6` \
		`use_enable xface compface` \
		`use_enable imlib` \
		`use_enable gnome gdk-pixbuf` \
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
