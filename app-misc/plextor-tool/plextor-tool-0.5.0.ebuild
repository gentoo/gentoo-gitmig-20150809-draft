# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/plextor-tool/plextor-tool-0.5.0.ebuild,v 1.1 2004/08/29 15:52:25 vapier Exp $

DESCRIPTION="Tool to change the parameters of a Plextor CD-ROM drive"
HOMEPAGE="http://das.ist.org/~georg/"
SRC_URI="http://das.ist.org/~georg/files/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="static gnome"

RDEPEND="virtual/libc
	gnome? ( gnome-base/gnome-panel )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}/src
	sed -i \
		-e "/^CFLAGS=/s:$: ${CFLAGS}:" \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	cd ${S}/src
	local targets="plextor-tool"
	use static && targets="${targets} pt-static"
	use gnome && targets="${targets} plextor-tool-applet"
#	use static && use gnome && targets="${targets} pta-static"
	echo ${targets} > my-make-targets
	emake ${targets} || die "make ${targets} failed"
}

src_install() {
	local targets="$(<src/my-make-targets)"
	dodoc src/TODO doc/README doc/NEWS
	cd src
	dobin ${targets} || die "dobin failed"
	doman plextor-tool.8.gz
}
