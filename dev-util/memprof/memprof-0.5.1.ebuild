# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/memprof/memprof-0.5.1.ebuild,v 1.8 2004/06/25 02:40:26 agriffis Exp $

inherit gnome2

DESCRIPTION="MemProf - Profiling and leak detection"
HOMEPAGE="http://www.gnome.org/projects/memprof/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	sys-devel/libtool"

RDEPEND="${DEPEND}
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog README NEWS"
