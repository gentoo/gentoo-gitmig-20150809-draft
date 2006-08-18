# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.0.0.ebuild,v 1.2 2006/08/18 19:29:33 compnerd Exp $

inherit eutils gnome2

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"
SRC_URI="mirror://gnome/sources/glade3/3.0/glade3-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gnome"

RDEPEND=">=dev-libs/glib-2.8.0
		 >=x11-libs/gtk+-2.8.0
		 >=dev-libs/libxml2-2.4
		 gnome?	(
					>=gnome-base/libgnomeui-2.0
					>=gnome-base/libbonoboui-2.0
				)"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.29
		>=dev-util/pkgconfig-0.19
		doc? ( >=dev-util/gtk-doc-1.4 )"

S="${WORKDIR}/glade3-${PV}"
DOCS="AUTHORS BUGS ChangeLog HACKING INTERNALS MAINTAINERS NEWS README TODO"

pkg_config() {
	G2CONF="${G2CONF} $(use_enable gnome)"
}
