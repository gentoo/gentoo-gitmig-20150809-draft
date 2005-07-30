# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sysprof/sysprof-0.91.ebuild,v 1.1 2005/07/30 04:15:40 vapier Exp $

inherit linux-mod

DESCRIPTION="System-wide Linux Profiler"
HOMEPAGE="http://www.daimi.au.dk/~sandmann/sysprof/"
SRC_URI="http://www.daimi.au.dk/~sandmann/sysprof/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0"

pkg_setup() {
	MODULE_NAMES="sysprof-module(misc:${S}/module)"
	CONFIG_CHECK="PROFILING"
	PROFILING_ERROR="You need to enable Profiling support in your kernel."
	BUILD_TARGETS="all"
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^SUBDIRS/s:module::' \
		Makefile.in || die
}

src_compile() {
	econf || die
	emake || die
	linux-mod_src_compile
}

src_install() {
	make install DESTDIR="${D}" || die
	linux-mod_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO
}
