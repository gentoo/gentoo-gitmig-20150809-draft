# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed/sylpheed-0.9.5-r1.ebuild,v 1.4 2004/02/17 23:24:06 agriffis Exp $

IUSE="ssl xface ipv6 nls gnome ldap crypt pda gtk2"

inherit eutils

S=${WORKDIR}/${P}
PATCHVER="20030906"
DESCRIPTION="A lightweight email client and newsreader"
SRC_URI="http://sylpheed.good-day.net/${PN}/${P}.tar.bz2
	gtk2? ( mirror://sourceforge/${PN}-gtk2/${P}-gtk2-${PATCHVER}.diff.gz )"

HOMEPAGE="http://sylpheed.good-day.net
http://www.homa.ne.jp/~ashie/linux/sylpheed-gtk2.html.en"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa"

PROVIDE="virtual/sylpheed"

DEPEND="
	gtk2? ( >=x11-libs/gtk+-2.0  )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	xface? ( >=media-libs/compface-1.4 )
	ssl? ( dev-libs/openssl )
	pda? ( app-pda/jpilot )
	crypt? ( >=app-crypt/gnupg-1.0.6 =app-crypt/gpgme-0.3.14 )
	ldap? ( >=net-nds/openldap-2.0.11 )
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )
	x11-misc/shared-mime-info"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/shared-mime.patch
	use gtk2 && gunzip -dc ${DISTDIR}/sylpheed-${PV}-gtk2-${PATCHVER}.diff.gz >sylpheed-${PV}-gtk2-${PATCHVER}.diff

#	use gtk2 && patch  <${FILESDIR}/gtk2-patch-fix.patch
	use gtk2 && epatch  sylpheed-${PV}-gtk2-${PATCHVER}.diff
}

src_compile() {
	local myconf
	if [ `use gtk2` ];
	then
		myconf="${myconf} --enable-gdk-pixbuf"
	else
		use gnome || myconf="${myconf} --disable-gdk-pixbuf --disable-imlib"
		use nls || myconf="${myconf} --disable-nls"
	fi


	use ssl && myconf="${myconf} --enable-ssl"

	use crypt && myconf="${myconf} --enable-gpgme"

	use pda && myconf="${myconf} --enable-jpilot"

	use ldap && myconf="${myconf} --enable-ldap"

	use ipv6 && myconf="${myconf} --enable-ipv6"

	use xface || myconf="${myconf} --disable-compface"

	# build fails if this is done normally. dunno why and didn't bother to find out. : )
	use gtk2 && ./autogen.sh

	econf ${myconf}

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
