# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.4.0.ebuild,v 1.3 2007/12/12 18:33:08 armin76 Exp $

inherit eutils gnome2

MY_PN="glade3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha ~amd64 ia64 ~ppc ppc64 sparc x86"
IUSE="doc gnome"

RDEPEND=">=dev-libs/glib-2.8.0
		 >=x11-libs/gtk+-2.10.0
		 >=dev-libs/libxml2-2.4
		 gnome?	(
					>=gnome-base/libgnomeui-2.0
					>=gnome-base/libbonoboui-2.0
				)"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19
		doc? ( >=dev-util/gtk-doc-1.4 )"

S="${WORKDIR}/${MY_P}"
DOCS="AUTHORS BUGS ChangeLog HACKING INTERNALS MAINTAINERS NEWS README TODO"

pkg_config() {
	G2CONF="${G2CONF} $(use_enable gnome)"
}
