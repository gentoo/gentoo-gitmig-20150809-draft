# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed/sylpheed-0.8.5-r1.ebuild,v 1.6 2003/04/25 20:09:41 vapier Exp $

DESCRIPTION="A lightweight email client and newsreader"
SRC_URI="http://sylpheed.good-day.net/${PN}/${P}.tar.bz2"
HOMEPAGE="http://sylpheed.good-day.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="ssl nls gnome ldap crypt pda ipv6"

PROVIDE="virtual/sylpheed"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/compface-1.4
	ssl? ( dev-libs/openssl )
	pda? ( app-misc/jpilot )
	crypt? ( >=app-crypt/gnupg-1.0.6 =app-crypt/gpgme-0.3.14 )
	ldap? ( >=net-nds/openldap-2.0.11 )
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )"


RDEPEND="=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	crypt? ( >=app-crypt/gnupg-1.0.6 >=app-crypt/gpgme-0.2.3 )
	ldap? ( >=net-nds/openldap-2.0.11 )
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )"

src_compile() {
	local myconf=""

	use gnome || myconf="--disable-gdk-pixbuf --disable-imlib"
	use nls   || myconf="$myconf --disable-nls"
	use ssl   && myconf="$myconf --enable-ssl"
	use crypt && myconf="$myconf --enable-gpgme"
	use pda   && myconf="$myconf --enable-jpilot"
	use ldap  && myconf="$myconf --enable-ldap"
	use ipv6  && myconf="$myconf --enable-ipv6"
	
	econf $myconf || die "./configure failed"
	
	emake || die "Compilation failed"
}

src_install () {
	einstall \
		manualdir=${D}/usr/share/doc/${PF}/html || die

	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins sylpheed.png

		insinto /usr/share/gnome/apps/Internet
		doins sylpheed.desktop
	fi
		
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog* NEWS README* TODO*
}
