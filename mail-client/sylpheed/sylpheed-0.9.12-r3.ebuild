# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed/sylpheed-0.9.12-r3.ebuild,v 1.1 2004/08/27 13:22:19 dragonheart Exp $

inherit eutils

IUSE="ssl xface ipv6 imlib nls gnome ldap crypt pda gtk2"

GTK2_PATCHVER="20040622"

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.good-day.net/
	http://sylpheed-gtk2.sf.net/"
SRC_URI="http://sylpheed.good-day.net/${PN}/${P}.tar.bz2
	gtk2? ( mirror://sourceforge/${PN}-gtk2/${P}-gtk2-${GTK2_PATCHVER}.diff.gz )"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64"
SLOT="0"

PROVIDE="virtual/sylpheed"

DEPEND="gtk2? ( >=x11-libs/gtk+-2.2 )
	!gtk2? ( =x11-libs/gtk+-1.2*
		gnome? ( media-libs/gdk-pixbuf )
		imlib? ( media-libs/imlib )
	)
	!amd64? ( nls? ( =sys-devel/gettext-0.12.1* ) )
	ssl? ( dev-libs/openssl )
	pda? ( app-pda/jpilot )
	ldap? ( >=net-nds/openldap-2.0.11 )
	crypt? ( =app-crypt/gpgme-0.3.14-r1 )
	xface? ( >=media-libs/compface-1.4 )"
RDEPEND="${DEPEND}
	app-misc/mime-types
	x11-misc/shared-mime-info"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-namespace.diff
	epatch ${FILESDIR}/${PN}-procmime.diff
	epatch ${FILESDIR}/${P}-64bit.patch

	if use gtk2; then
		epatch ${WORKDIR}/${P}-gtk2-${GTK2_PATCHVER}.diff
	fi
	! use crypt && cp ac/missing/gpgme.m4 ac
	! use gnome && cp ac/missing/gdk-pixbuf.m4 ac
	! use imlib && cp ac/missing/imlib.m4 ac

	aclocal -I ac || die "aclocal failed"
	libtoolize --force --copy || die "libtoolize died"
	autoheader || die "autoheader died"

	# had to do this to prevent failure.
	if use gtk2;
	then
		aclocal -I ac || die "2nd aclocal failed"
	fi
	automake --add-missing --foreign --copy || die "automake failed"
	autoconf || die "failed to autoconf"
}

src_compile() {

	local myconf

	# for gpgme support
	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config

	# For gnupg-1.9
	if [ -x ${ROOT}/usr/bin/gpg ];
	then
		export GPG_PATH=${ROOT}/usr/bin/gpg
	elif [ -x ${ROOT}/usr/bin/gpg2 ];
	then
		export GPG_PATH=${ROOT}/usr/bin/gpg2
	fi

	if use gtk2; then
		myconf="--enable-gdk-pixbuf"

	else
		myconf="`use_enable imlib` `use_enable gnome gdk-pixbuf`"

	fi

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
