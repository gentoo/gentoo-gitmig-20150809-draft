# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-2.8.3.ebuild,v 1.12 2006/10/19 16:12:01 kloeri Exp $

inherit gnome2

DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-cpp/glibmm-2.7
	>=x11-libs/gtk+-2.7
	>=dev-libs/libsigc++-2.0
	>=dev-libs/atk-1.9.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

G2CONF="--disable-examples --disable-demos"

DOCS="AUTHORS CHANGES ChangeLog PORTING NEWS README"
