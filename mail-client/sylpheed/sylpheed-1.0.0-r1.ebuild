# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed/sylpheed-1.0.0-r1.ebuild,v 1.1 2005/01/06 15:03:45 hattya Exp $

inherit eutils

IUSE="crypt gnome gtk2 imlib ipv6 ldap nls pda ssl xface"

GTK2_PV="20041224"
MY_P="${P}-gtk2-${GTK2_PV}"

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.good-day.net/
	http://sylpheed-gtk2.sf.net/"
SRC_URI="http://sylpheed.good-day.net/${PN}/${P}.tar.bz2
	gtk2? ( mirror://sourceforge/${PN}-gtk2/${MY_P}.diff.gz )"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64"
SLOT="0"

PROVIDE="virtual/sylpheed"

DEPEND="gtk2? ( >=x11-libs/gtk+-2.2 )
	!gtk2? ( =x11-libs/gtk+-1.2*
		gnome? ( media-libs/gdk-pixbuf )
		imlib? ( media-libs/imlib )
	)
	!amd64? ( nls? ( >=sys-devel/gettext-0.12.1 ) )
	crypt? ( =app-crypt/gpgme-0.3.14-r1 )
	ldap? ( >=net-nds/openldap-2.0.11 )
	pda? ( app-pda/jpilot )
	ssl? ( dev-libs/openssl )
	xface? ( >=media-libs/compface-1.4 )"
RDEPEND="${DEPEND}
	app-misc/mime-types
	x11-misc/shared-mime-info"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-namespace.diff
	epatch ${FILESDIR}/${PN}-procmime.diff

	if use gtk2; then
		epatch ${WORKDIR}/${MY_P}.diff
		! use crypt && cp ac/missing/gpgme.m4 ac
		WANT_AUTOMAKE=1.7 ./autogen.sh
	fi

}

src_compile() {

	local myconf

	if use gtk2; then
		myconf="--enable-gdk-pixbuf"

	else
		myconf="`use_enable imlib` `use_enable gnome gdk-pixbuf`"

	fi

	use crypt && export GPGME_CONFIG="${ROOT}usr/bin/gpgme3-config"

	econf \
		`use_enable nls` \
		`use_enable ssl` \
		`use_enable crypt gpgme` \
		`use_enable pda jpilot` \
		`use_enable ldap` \
		`use_enable ipv6` \
		`use_enable xface compface` \
		${myconf} \
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
