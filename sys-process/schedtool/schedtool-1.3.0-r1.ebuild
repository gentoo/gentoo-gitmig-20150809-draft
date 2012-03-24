# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/schedtool/schedtool-1.3.0-r1.ebuild,v 1.3 2012/03/24 11:14:16 ago Exp $

EAPI=4

DESCRIPTION="A tool to query or alter a process' scheduling policy."
HOMEPAGE="http://freequaos.host.sk/schedtool"
SRC_URI="http://freequaos.host.sk/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 ~mips ~ppc ~x86"
IUSE=""

src_prepare() {
	sed -i '/^CFLAGS=/d;/^install:/s/install-doc//' Makefile
}

src_install() {
	make DESTPREFIX="${D}"/usr install || die
	dodoc CHANGES INSTALL PACKAGERS README SCHED_DESIGN TODO TUNING
}
