# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.11.91.ebuild,v 1.2 2005/08/20 08:00:59 joem Exp $

inherit eutils gnome2

DESCRIPTION="Gnome session manager"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="${SRC_URI} mirror://gentoo/gentoo-splash.png"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="esd ipv6"

RDEPEND=">=x11-libs/gtk+-2.3.1
	esd? ( >=media-sound/esound-0.2.26 )
	>=gnome-base/libgnomeui-2.2
	>=sys-apps/tcp-wrappers-7.6
	>=gnome-base/gconf-2
	gnome-base/gnome-keyring"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.40
	>=dev-util/pkgconfig-0.17
	dev-util/intltool
	!gnome-base/gnome-core"
# gnome-base/gnome-core overwrite /usr/bin/gnome-session

G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable esd)"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

USE_DESTDIR="1"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}

	# Patch for logout dialog and automatic session save now reverted. See bug
	# #95745. Patch to set the Gentoo splash by default in the gconf key
	# (#42687)
	epatch ${FILESDIR}/${PN}-2.10.0-schema_defaults.patch

	# Implement switch to enable/disable esound support. See bug #6920.
	epatch ${FILESDIR}/${PN}-2.10.0-esd_switch.patch


	# Hide the splash after defaults have been loaded, a temp workaround
	# for http://bugzilla.gnome.org/show_bug.cgi?id=116814
	epatch ${FILESDIR}/${PN}-2.8.1-hide_splash.patch

	export WANT_AUTOMAKE=1.7
	cp aclocal.m4 old_macros.m4
	einfo "Running aclocal"
	aclocal -I . || die "aclocal failed"
	einfo "Running autoconf"
	autoconf || die "autoconf failed"
	einfo "Running automake"
	automake || die "automake failed"
	einfo "Running libtoolize"
	libtoolize --copy --force
}

src_install() {

	gnome2_src_install

	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome

	# Our own splash for world domination
	insinto /usr/share/pixmaps/splash/
	doins ${DISTDIR}/gentoo-splash.png

}
