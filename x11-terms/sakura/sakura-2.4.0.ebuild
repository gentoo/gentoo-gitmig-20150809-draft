# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/sakura/sakura-2.4.0.ebuild,v 1.2 2011/02/25 00:30:08 jmbsvicetto Exp $

inherit cmake-utils

DESCRIPTION="sakura is a terminal emulator based on GTK and VTE"
HOMEPAGE="http://www.pleyades.net/david/sakura.php"
SRC_URI="http://www.pleyades.net/david/projects/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.20
	>=x11-libs/gtk+-2.16
	>=x11-libs/vte-0.26
"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.10.1
	>=dev-util/cmake-2.4.7
"

# cmake-utils variables
DOCS="AUTHORS INSTALL"
