# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekiga/ekiga-2.0.1.ebuild,v 1.2 2006/03/21 21:33:12 genstef Exp $

inherit gnome2 eutils flag-o-matic

DESCRIPTION="H.323 and SIP VoIP softphone"
HOMEPAGE="http://www.ekiga.org/"
SRC_URI="http://www.ekiga.org/includes/clicks_counter.php?http://www.ekiga.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="avahi dbus gnome ipv6 sdl ssl"

RDEPEND="~dev-libs/pwlib-1.10.0
	~net-libs/opal-2.2.1
	>=net-nds/openldap-2.0.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.0.0
	>=dev-libs/libxml2-2.6.1
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.4 )
	dbus? ( >=sys-apps/dbus-0.22 )
	avahi? ( net-dns/avahi )
	gnome? ( >=gnome-base/libbonoboui-2.2.0
		>=gnome-base/libbonobo-2.2.0
		>=gnome-base/libgnomeui-2.2.0
		>=gnome-base/libgnome-2.2.0
		>=gnome-base/gnome-vfs-2.2.0
		>=gnome-base/gconf-2.2.0
		>=gnome-base/orbit-2.5.0
		gnome-extra/evolution-data-server
		>=media-sound/esound-0.2.28 )"


DEPEND="${RDEPEND}
	dev-lang/perl
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.20
	gnome? ( app-text/scrollkeeper )"

pkg_setup() {
	if ! built_with_use dev-libs/pwlib ldap; then
		einfo "You need to build dev-libs/pwlib with USE=ldap enabled."
		die "Pwlib w/o ldap-support detected."
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix configure to install schemafile into the proper directory
	epatch ${FILESDIR}/${PN}-1.99.0-configure.patch
}

src_compile() {
	local myconf

	# filter -O3, causes trouble with plugins (bug #88710)
	replace-flags -O3 -O2

	#
	# don't touch! yes, it works this way.
	# no, changing to use_enable / use_with breaks it
	#
	if use ssl; then
		myconf="${myconf} --with-openssl-libs=/usr/lib"
		myconf="${myconf} --with-openssl-includes=/usr/include/openssl"
	fi

	use sdl \
		&& myconf="${myconf} --with-sdl-prefix=/usr" \
		|| myconf="${myconf} --disable-sdltest"

	use gnome \
		|| myconf="${myconf} --disable-gnome --disable-scrollkeeper --disable-schemas-install"

	use dbus \
		&& myconf="${myconf} --enable-dbus"

	use avahi \
		|| myconf="${myconf} --disable-avahi"

	econf \
		$(use_enable ipv6) \
		${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	if use gnome; then
		gnome2_src_install
	else
		make DESTDIR=${D} install || die "make install failed"
		rm -rf ${D}/usr/lib/bonobo

		dodoc AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO
	fi
}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
