# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-2.10.0.ebuild,v 1.1 2005/04/21 02:40:52 allanonjl Exp $

inherit eutils gnome2

DESCRIPTION="a GUI Builder.  This release is for GTK+ 2 and GNOME 2."
HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha"
IUSE="gnome gnomedb accessibility"

RDEPEND=">=x11-libs/gtk+-2.6.0
	>=dev-libs/libxml2-2.4.1
	gnome? ( >=gnome-base/libgnomeui-2.9.0
		>=gnome-base/libgnomecanvas-2.0.0
		>=gnome-base/libbonoboui-2.0.0
		accessibility? ( gnome-extra/libgail-gnome )
		)
	gnomedb? ( >=gnome-extra/libgnomedb-0.90.3
			>=gnome-extra/libgda-0.90.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=app-text/scrollkeeper-0.3.10
	>=dev-util/intltool-0.30"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix
}

G2CONF="${G2CONF} `use_enable gnome` `use_enable gnomedb gnome-db`"

DOCS="ABOUT-NLS AUTHORS COPYING FAQ INSTALL NEWS README TODO"
USE_DESTDIR="1"
