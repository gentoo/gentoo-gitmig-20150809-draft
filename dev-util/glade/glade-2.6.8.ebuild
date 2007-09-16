# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-2.6.8.ebuild,v 1.12 2007/09/16 22:15:39 eva Exp $

inherit eutils gnome2

DESCRIPTION="a GUI Builder.  This release is for GTK+ 2 and GNOME 2."
HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="gnome libgda"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/libxml2-2.4.1
	gnome? ( >=gnome-base/libgnomeui-2.6.0
		>=gnome-base/libgnomecanvas-2.0.0
		>=gnome-base/libbonoboui-2.0.0 )
	libgda? ( =gnome-extra/libgnomedb-1*
			=gnome-extra/libgda-1* )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=app-text/scrollkeeper-0.3.10
	>=dev-util/intltool-0.30"

DOCS="AUTHORS FAQ INSTALL NEWS README TODO"
USE_DESTDIR="1"

src_unpack() {
	gnome2_src_unpack

	# this patch fixes potential issues
	# with scrollkeeper. speeds up unnecessary scroll generation
	epatch ${FILESDIR}/${PN}-2.0.0-scrollkeeper.patch
}

pkg_config() {
	G2CONF="${G2CONF} $(use_enable gnome) $(use_enable libgda gnome-db)"
}

src_install() {

	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/

}
