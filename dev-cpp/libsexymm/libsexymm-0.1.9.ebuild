# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libsexymm/libsexymm-0.1.9.ebuild,v 1.1 2006/10/16 20:53:03 dev-zero Exp $

inherit gnome2

DESCRIPTION="C++ Bindings for libsexy"
HOMEPAGE="http://www.chipx86.com/wiki/Libsexy/"
SRC_URI="http://releases.chipx86.com/libsexy/libsexymm/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=dev-cpp/glibmm-2.4
		 >=dev-cpp/gtkmm-2.4
		 >=x11-libs/libsexy-0.1.9"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"
