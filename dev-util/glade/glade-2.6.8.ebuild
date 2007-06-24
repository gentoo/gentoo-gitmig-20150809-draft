# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-2.6.8.ebuild,v 1.11 2007/06/24 09:15:27 eva Exp $

inherit eutils gnome2

DESCRIPTION="a GUI Builder.  This release is for GTK+ 2 and GNOME 2."
HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="gnome gnomedb"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/libxml2-2.4.1
	gnome? ( >=gnome-base/libgnomeui-2.6.0
		>=gnome-base/libgnomecanvas-2.0.0
		>=gnome-base/libbonoboui-2.0.0 )
	gnomedb? ( =gnome-extra/libgnomedb-1*
			=gnome-extra/libgda-1* )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=app-text/scrollkeeper-0.3.10
	>=dev-util/intltool-0.30"

src_unpack() {
	unpack ${A}
	# this patch fixes potential potential issues
	# with scrollkeeper. speeds up unnecessary scroll generation
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.0.0-scrollkeeper.patch
}

G2CONF="${G2CONF} `use_enable gnome` `use_enable gnomedb gnome-db`"

DOCS="AUTHORS FAQ INSTALL NEWS README TODO"
USE_DESTDIR="1"

src_install() {

	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/

}
