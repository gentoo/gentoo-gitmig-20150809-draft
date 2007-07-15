# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/glibmm/glibmm-2.4.4.ebuild,v 1.11 2007/07/15 04:01:12 mr_bones_ Exp $

inherit gnome2

DESCRIPTION="C++ interface for glib2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ppc amd64 sparc ppc64 hppa"
IUSE=""

RDEPEND=">=dev-libs/libsigc++-2.0
	>=dev-libs/glib-2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS CHANGES ChangeLog NEWS README"
