# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libgnome-java/libgnome-java-2.12.5-r1.ebuild,v 1.1 2006/12/17 13:28:38 betelgeuse Exp $

inherit java-gnome

DESCRIPTION="Java bindings for GNOME"
HOMEPAGE="http://java-gnome.sourceforge.net/"

SLOT="2.12"
KEYWORDS="~amd64 ~ppc ~x86"

DEPS=">=gnome-base/libgnome-2.10.0
		>=gnome-base/libgnomeui-2.12.0
		>=gnome-base/libgnomecanvas-2.12.0
		>=dev-java/glib-java-0.2.1
		>=dev-java/libgtk-java-2.8.1"

DEPEND="${DEPS}"
RDEPEND="${DEPS}"

JAVA_GNOME_PC="gnome2-java.pc"
