# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sysprof/sysprof-1.0.8.ebuild,v 1.1 2006/12/22 02:12:07 leio Exp $

inherit eutils linux-mod

DESCRIPTION="System-wide Linux Profiler"
HOMEPAGE="http://www.daimi.au.dk/~sandmann/sysprof/"
SRC_URI="http://www.daimi.au.dk/~sandmann/sysprof/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6
	x11-libs/pango
	>=gnome-base/libglade-2"

pkg_setup() {
	MODULE_NAMES="sysprof-module(misc:${S}/module)"
	CONFIG_CHECK="PROFILING"
	PROFILING_ERROR="You need to enable Profiling support in your kernel."
	BUILD_TARGETS="all"
	linux-mod_pkg_setup
}

src_compile() {
	econf --disable-kernel-module || die
	emake || die
	linux-mod_src_compile
}

src_install() {
	make install DESTDIR="${D}" || die
	linux-mod_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO
	make_desktop_entry sysprof Sysprof sysprof-icon.png
}
