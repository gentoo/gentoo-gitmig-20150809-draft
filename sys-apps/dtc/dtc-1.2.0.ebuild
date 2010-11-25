# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dtc/dtc-1.2.0.ebuild,v 1.2 2010/11/25 21:55:27 fauli Exp $

EAPI=2
inherit eutils toolchain-funcs

MY_P="${PN}-v${PV}"

DESCRIPTION="Open Firmware device-trees compiler"
HOMEPAGE="http://www.t2-project.org/packages/dtc.html"
SRC_URI="http://www.jdl.com/software/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "s:CFLAGS =:CFLAGS +=:" \
		   -e "s:CPPFLAGS =:CPPFLAGS +=:" Makefile || die
}

src_compile() {
	tc-export AR CC
	emake PREFIX="/usr" LIBDIR="/usr/$(get_libdir)" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="/usr/$(get_libdir)" \
		 install || die
	dodoc Documentation/manual.txt
}
