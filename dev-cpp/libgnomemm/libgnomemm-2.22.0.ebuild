# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomemm/libgnomemm-2.22.0.ebuild,v 1.8 2010/07/20 15:16:00 jer Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgnome"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.8
	>=gnome-base/libgnome-2.6"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"
