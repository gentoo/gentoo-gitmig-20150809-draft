# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dtc/dtc-1.0.0.ebuild,v 1.5 2008/02/20 23:01:54 coldwind Exp $

inherit eutils

DESCRIPTION="Utility to pre-compile Open Firmware device-trees for otherwise device-tree-less devices such as the PS3"
HOMEPAGE="http://www.t2-project.org/packages/dtc.html"
SRC_URI="http://www.jdl.com/software/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~x86"
IUSE=""
S="${WORKDIR}/${PN}"

src_compile () {
	emake PREFIX="/usr" LIBDIR="/usr/$(get_libdir)"
}

src_install () {
	make DESTDIR="${D}" \
		 PREFIX="/usr" \
		 LIBDIR="/usr/$(get_libdir)" \
		 install
	dodoc Documentation/manual.txt
}
