# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.4.2.ebuild,v 1.3 2004/02/08 21:58:16 spider Exp $

inherit gnome2

DESCRIPTION="Gnome session manager"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2 FDL-1.1"

IUSE="ipv6"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

RDEPEND=">=x11-libs/gtk+-2.2
	>=media-sound/esound-0.2.26
	>=gnome-base/libgnomeui-2.2
	>=sys-apps/tcp-wrappers-7.6
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.40
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	!gnome-base/gnome-core
	dev-perl/XML-Parser"
# gnome-base/gnome-core overwrites /usr/bin/gnome-session

DOCS="AUTHORS ChangeLog COPYING* HACKING INSTALL NEWS README"

G2CONF="${G2CONF} $(use_enable ipv6)"

src_unpack() {

	unpack ${A}
	cd ${S}

	# patch for logout dialog, see bug # 30230 and dups
	epatch ${FILESDIR}/${PN}-2.4-defaults.patch

}

src_install() {

	gnome2_src_install

	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome

	# Our own splash for world domination
	# FIXME : in an ideal world we would alter the gconf key
	insinto /usr/share/pixmaps/splash/
	doins ${FILESDIR}/gnome-splash.png

}
