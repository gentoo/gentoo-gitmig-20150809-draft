# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.1.2.ebuild,v 1.1 2006/12/06 23:09:57 compnerd Exp $

inherit eutils gnome2

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"
SRC_URI="mirror://gnome/sources/glade3/3.1/glade3-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="devhelp doc gnome"

RDEPEND=">=dev-libs/glib-2.8.0
		 >=x11-libs/gtk+-2.8.0
		 >=dev-libs/libxml2-2.4
		 !alpha? ( !ppc64? ( devhelp? ( >=dev-util/devhelp-0.12 ) ) )
		 gnome?	(
					>=gnome-base/libgnomeui-2.0
					>=gnome-base/libbonoboui-2.0
				)"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19
		doc? ( >=dev-util/gtk-doc-1.4 )"

S="${WORKDIR}/glade3-${PV}"
DOCS="AUTHORS BUGS ChangeLog HACKING INTERNALS MAINTAINERS NEWS README TODO"

pkg_config() {
	G2CONF="${G2CONF} $(use_with devhelp) $(use_enable gnome)"
}
