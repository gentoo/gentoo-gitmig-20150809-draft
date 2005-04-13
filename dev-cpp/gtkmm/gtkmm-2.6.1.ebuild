# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-2.6.1.ebuild,v 1.3 2005/04/13 19:29:28 cryos Exp $

inherit gnome2

DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~ppc64 ~hppa"
IUSE=""
G2CONF="--disable-examples --disable-demos"

RDEPEND=">=dev-cpp/glibmm-2.6
	>=x11-libs/gtk+-2.6
	>=dev-libs/libsigc++-2.0
	>=dev-libs/atk-1.9.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS CHANGES ChangeLog PORTING NEWS README"
