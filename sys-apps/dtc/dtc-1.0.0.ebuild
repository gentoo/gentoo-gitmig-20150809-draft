# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dtc/dtc-1.0.0.ebuild,v 1.6 2010/07/06 20:06:19 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Utility to pre-compile Open Firmware device-trees for otherwise device-tree-less devices such as the PS3"
HOMEPAGE="http://www.t2-project.org/packages/dtc.html"
SRC_URI="http://www.jdl.com/software/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
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
