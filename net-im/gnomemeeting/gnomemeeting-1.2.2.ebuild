# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-1.2.2.ebuild,v 1.4 2006/07/12 09:07:42 corsair Exp $

inherit gnome2 eutils flag-o-matic

DESCRIPTION="H.323 videoconferencing and VoIP softphone"
HOMEPAGE="http://www.gnomemeeting.org/"
# now part of gnome-2.4
SRC_URI="http://www.gnomemeeting.org/includes/clicks_counter.php?http://www.gnomemeeting.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus gnome howl ipv6 sdl ssl"

RDEPEND="~dev-libs/pwlib-1.8.7
	~net-libs/openh323-1.15.6
	>=net-nds/openldap-2.0.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.0.0
	>=dev-libs/libxml2-2.6.1
	>=media-sound/esound-0.2.28
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.4 )
	dbus? ( >=sys-apps/dbus-0.22 )
	howl? ( >=net-misc/howl-0.9.7 )
	gnome? ( >=gnome-base/libbonoboui-2.2.0
		>=gnome-base/libbonobo-2.2.0
		>=gnome-base/libgnomeui-2.2.0
		>=gnome-base/libgnome-2.2.0
		>=gnome-base/gnome-vfs-2.2.0
		>=gnome-base/gconf-2.2.0
		>=gnome-base/orbit-2.5.0
		gnome-extra/evolution-data-server )"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.20
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-devel/automake-1.7
	sys-devel/autoconf
	gnome? ( app-text/scrollkeeper )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix configure to install schemafile into the proper directory
	epatch ${FILESDIR}/${PN}-1.2.1-configure.patch

	# Relax dbus version check and fix installation of service file
	epatch ${FILESDIR}/${PN}-1.2.2-dbus.diff
	WANT_AUTOMAKE=1.7 automake || die
	autoconf || die
}

src_compile() {
	local myconf

	# filter -O3, causes trouble with plugins (bug #88710)
	replace-flags -O3 -O2

	#
	# i'm going to break your fingers if you touch these!
	#
	if use ssl; then
		myconf="${myconf} --with-openssl-libs=/usr/lib"
		myconf="${myconf} --with-openssl-includes=/usr/include/openssl"
	fi

	use sdl \
		&& myconf="${myconf} --with-sdl-prefix=/usr" \
		|| myconf="${myconf} --disable-sdltest"

	use gnome \
		|| myconf="${myconf} --disable-gnome"

	use dbus \
		&& myconf="${myconf} --enable-dbus"

	use howl \
		|| myconf="${myconf} --disable-howl"

	econf \
		--prefix=/usr \
		--host=${CHOST} \
		${myconf} \
		$(use_enable ipv6) || die "configure failed"
	emake -j1 || die
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

pkg_postinst() {

	if use gnome; then
		gnome2_pkg_postinst
		# we need to fix the GConf permissions, see bug #59764
		# <obz@gentoo.org>
		einfo "Fixing GConf permissions for gnomemeeting"
		gnomemeeting-config-tool --fix-permissions
	fi
}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
