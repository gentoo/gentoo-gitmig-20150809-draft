# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.4.0.ebuild,v 1.14 2004/01/30 05:48:01 drobbins Exp $

inherit gnome2

DESCRIPTION="A filemanager for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"
SLOT="0"
LICENSE="GPL-2 LGPL-2 FDL-1.1"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64"
IUSE="oggvorbis cups"

# depend on libbonobo-2.3 and up to remove bonobo-activation dep

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gnome-vfs-2.3.5
	>=media-sound/esound-0.2.27
	>=gnome-base/eel-${PV}
	>=gnome-base/gconf-2.3
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.3.3
	>=gnome-base/gnome-desktop-2.2
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/librsvg-2.0.1
	>=gnome-base/ORBit2-2.4
	>=x11-libs/startup-notification-0.5
	dev-libs/popt
	app-admin/fam
	sys-apps/eject
	oggvorbis? ( media-sound/vorbis-tools )
	cups? ( net-print/libgnomecups
		net-print/gnome-cups-manager )"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=sys-devel/autoconf-2.58"

PDEPEND="x11-themes/gnome-icon-theme
	x11-themes/gnome-themes"

DOCS="AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"

src_unpack() {

	unpack ${A}

	cd ${S}

	# patch for startup fix, see bug #28778
	epatch ${FILESDIR}/${PN}-2.4-startup-bonobo.patch

	if [ `use cups` ]; then
		epatch ${FILESDIR}/${PN}-2-x-printers.patch
		WANT_AUTOCONF=2.5 autoconf || die
		WANT_AUTOMAKE=1.6 automake || die
	fi

}
