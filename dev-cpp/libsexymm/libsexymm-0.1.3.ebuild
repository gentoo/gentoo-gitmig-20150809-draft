# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libsexymm/libsexymm-0.1.3.ebuild,v 1.1 2005/12/23 22:09:48 compnerd Exp $

inherit gnome2

DESCRIPTION="C++ Bindings for libsexy"
HOMEPAGE="http://www.chipx86.com/wiki/Libsexy/"
SRC_URI="http://osiris.chipx86.com/projects/libsexy/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-cpp/glibmm-2.4
		 >=dev-cpp/gtkmm-2.4
		 >=x11-libs/libsexy-0.1.3"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"
