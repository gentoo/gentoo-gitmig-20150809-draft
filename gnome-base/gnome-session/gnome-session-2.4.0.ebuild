# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.4.0.ebuild,v 1.11 2004/01/26 00:23:42 vapier Exp $

inherit gnome2

DESCRIPTION="Gnome session manager"
HOMEPAGE="http://www.gnome.org/"

IUSE="ipv6"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64"
LICENSE="GPL-2 LGPL-2 FDL-1.1"

RDEPEND=">=x11-libs/gtk+-2.2
	>=media-sound/esound-0.2.26
	>=gnome-base/libgnomeui-2.2
	>=sys-apps/tcp-wrappers-7.6"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.40
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	!gnome-base/gnome-core"
# gnome-base/gnome-core overwrite /usr/bin/gnome-session

DOCS="AUTHORS ChangeLog COPYING* HACKING NEWS README"

G2CONF="${G2CONF} $(use_enable ipv6)"

src_unpack() {
	unpack ${A}
	cd ${S}

	# patch for logout dialog, see bug # 30230 and dups
	epatch ${FILESDIR}/gnome-session-2.4-defaults.patch

	# This patch is only necessary on 64-bit platforms such as Alpha
	# but it doesn't hurt elsewhere.
#	epatch ${FILESDIR}/${PN}-2.0.9-64bit.patch || die

#	WANT_AUTOCONF=2.5 autoconf || die
#	automake
}

src_install() {
	gnome2_src_install

	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome

	# Our own splash for world domination
	# FIXME : in an ideal world we would alter the gconf key
#	insinto /usr/share/pixmaps/splash/
#	doins ${FILESDIR}/gnome-splash.png
}
