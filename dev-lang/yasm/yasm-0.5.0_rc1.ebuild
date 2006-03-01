# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yasm/yasm-0.5.0_rc1.ebuild,v 1.1 2006/03/01 00:42:17 kugelfang Exp $

inherit versionator

DESCRIPTION="assembler that supports amd64"
HOMEPAGE="http://www.tortall.net/projects/yasm/"
MYP="${PN}-$(delete_version_separator 3 ${PV})"
S="${WORKDIR}/${MYP}"
SRC_URI="http://www.tortall.net/projects/yasm/releases/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL
}
