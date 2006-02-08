# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-gnome/java-gnome-2.12.3.ebuild,v 1.1 2006/02/08 00:36:46 compnerd Exp $

inherit eutils

DESCRIPTION="JAVA bindings for GNOME"
HOMEPAGE="http://java-gnome.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="2.12"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="~dev-java/glib-java-0.2.3
		~dev-java/cairo-java-1.0.2
		~dev-java/libgtk-java-2.8.3
		~dev-java/libgnome-java-2.12.1
		~dev-java/libglade-java-2.12.2
		~dev-java/libgconf-java-2.12.1
		!<dev-java/java-gnome-2.8"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo
	einfo "There has been a major change in the java-gnome package as of the 2.8"
	einfo "version.  The package has been modularized, this is just a metapackage"
	einfo "which will install all the components."
	einfo
	einfo "The java-gnome project has added a core module glib-java which may in"
	einfo "the future gather other org.gnu.glib functionality from libgtk-java"
	einfo
	ebeep 5
}
