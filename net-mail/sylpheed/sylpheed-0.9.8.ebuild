# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed/sylpheed-0.9.8.ebuild,v 1.5 2004/03/25 10:07:19 kumba Exp $

IUSE="ssl xface ipv6 nls gnome ldap crypt pda"

inherit eutils

S=${WORKDIR}/${P}

DESCRIPTION="A lightweight email client and newsreader"
SRC_URI="http://sylpheed.good-day.net/${PN}/${P}.tar.bz2"
HOMEPAGE="http://sylpheed.good-day.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~amd64 ia64"

PROVIDE="virtual/sylpheed"

DEPEND="=x11-libs/gtk+-1.2*
	x11-misc/shared-mime-info
	!amd64? ( nls? ( =sys-devel/gettext-0.12.1* ) )
	ssl? ( dev-libs/openssl )
	pda? ( app-pda/jpilot )
	ldap? ( >=net-nds/openldap-2.0.11 )
	crypt? ( >=app-crypt/gnupg-1.0.6 =app-crypt/gpgme-0.3.14 )
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )
	xface? ( >=media-libs/compface-1.4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/shared-mime.patch
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
		`use_enable gnome gdk-pixbuf` \
		`use_enable gnome imlib` \
		|| die

	emake || die
}

src_install () {
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

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog* NEWS README* TODO*
}
