# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekiga/ekiga-2.0.7.ebuild,v 1.4 2007/03/23 17:32:31 wolf31o2 Exp $

inherit gnome2 eutils flag-o-matic

DESCRIPTION="H.323 and SIP VoIP softphone"
HOMEPAGE="http://www.ekiga.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE="avahi dbus doc gnome sdl"

RDEPEND="~dev-libs/pwlib-1.10.5
	~net-libs/opal-2.2.6
	>=net-nds/openldap-2.0.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.0.0
	>=dev-libs/libxml2-2.6.1
	sdl? ( >=media-libs/libsdl-1.2.4 )
	dbus? ( || ( >=dev-libs/dbus-glib-0.71
		( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.61 ) ) )
	avahi? ( net-dns/avahi )
	gnome? ( >=gnome-base/libbonoboui-2.2.0
		>=gnome-base/libbonobo-2.2.0
		>=gnome-base/libgnomeui-2.2.0
		>=gnome-base/libgnome-2.2.0
		>=gnome-base/gnome-vfs-2.2.0
		>=gnome-base/gconf-2.2.0
		>=gnome-base/orbit-2.5.0
		gnome-extra/evolution-data-server
		>=media-sound/esound-0.2.28
		doc? ( app-text/gnome-doc-utils ) )"


DEPEND="${RDEPEND}
	dev-lang/perl
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.20
	gnome? ( app-text/scrollkeeper )"

pkg_setup() {
	if ! built_with_use dev-libs/pwlib ldap; then
		eerror "You need to build dev-libs/pwlib with USE=ldap enabled."
		die "Pwlib w/o ldap-support detected."
	fi

	if use avahi && ! built_with_use net-dns/avahi dbus; then
		eerror "You need to build net-dns/avahi with USE=dbus enabled."
		die "Avahi without dbus-support detected."
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Fix configure to install schemafile into the proper directory
	epatch "${FILESDIR}"/${PN}-1.99.0-configure.patch
	epatch "${FILESDIR}"/${PN}-eggtrayicon-update.diff
	epatch "${FILESDIR}"/${PN}-eggtrayicon-transparency.diff
}

src_compile() {
	econf \
		$(use_enable dbus) \
		$(use_enable sdl) \
		$(use_enable avahi) \
		$(use_enable doc) \
		$(use_enable gnome) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	if use gnome; then
		gnome2_src_install
	else
		make DESTDIR="${D}" install || die "make install failed"

		dodoc AUTHORS ChangeLog NEWS
	fi
}

pkg_postinst() {
	if use gnome; then
		gnome2_pkg_postinst

		# we need to fix the GConf permissions, see bug #59764
		einfo "Fixing GConf permissions for ekiga"
		ekiga-config-tool --fix-permissions
	fi
}

DOCS="AUTHORS ChangeLog NEWS"
