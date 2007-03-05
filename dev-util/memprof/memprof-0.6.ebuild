# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/memprof/memprof-0.6.ebuild,v 1.1 2007/03/05 20:43:28 anant Exp $

inherit gnome2 eutils

DESCRIPTION="MemProf - Profiling and leak detection"
HOMEPAGE="http://www.gnome.org/projects/memprof/"
SRC_URI="${SRC_URI}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	sys-devel/libtool"

RDEPEND="${DEPEND}
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog README NEWS"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-Makefile.in.patch
}
