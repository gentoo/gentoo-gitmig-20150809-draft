# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.5.92.ebuild,v 1.1 2004/03/20 09:19:58 foser Exp $

inherit gnome2

DESCRIPTION="Gnome session manager"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2 FDL-1.1"

IUSE="ipv6"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=media-sound/esound-0.2.26
	>=gnome-base/libgnomeui-2.2
	>=sys-apps/tcp-wrappers-7.6
	>=gnome-base/gconf-2
	gnome-base/gnome-keyring"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.40
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	!gnome-base/gnome-core"
# gnome-base/gnome-core overwrite /usr/bin/gnome-session

G2CONF="${G2CONF} $(use_enable ipv6)"

DOCS="AUTHORS ChangeLog COPYING* HACKING INSTALL NEWS README"

USE_DESTDIR="1"

src_unpack() {

	unpack ${A}
	cd ${S}

	# patch for logout dialog, see bug # 30230 and dups
	# patch to set the Gentoo splash by default in the gconf key (#42687)
	epatch ${FILESDIR}/${PN}-2.6-schema_defaults.patch

}

src_install() {

	gnome2_src_install

	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome

	# Our own splash for world domination
	insinto /usr/share/pixmaps/splash/
	doins ${FILESDIR}/gentoo-splash.png

}
