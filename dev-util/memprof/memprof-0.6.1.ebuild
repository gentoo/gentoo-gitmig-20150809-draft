# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/memprof/memprof-0.6.1.ebuild,v 1.1 2009/07/16 20:53:57 mpagano Exp $

inherit gnome2 eutils

DESCRIPTION="MemProf - Profiling and leak detection"
HOMEPAGE="http://www.secretlabs.de/projects/memprof/"
SRC_URI="http://www.secretlabs.de/projects/memprof/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

RDEPEND="${DEPEND}
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog README NEWS"
