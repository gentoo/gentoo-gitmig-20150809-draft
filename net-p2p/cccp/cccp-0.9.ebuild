# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/cccp/cccp-0.9.ebuild,v 1.6 2011/08/31 06:42:16 mr_bones_ Exp $

EAPI=4

inherit toolchain-funcs

IUSE=""

DESCRIPTION="Scriptable console frontend to Direct Connect"
HOMEPAGE="http://members.chello.se/hampasfirma/cccp"
SRC_URI="http://members01.chello.se/hampasfirma/cccp/${PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

RDEPEND=">=net-p2p/dctc-0.83"
DEPEND=""

S="${WORKDIR}/${PN}.${PV}"

doecho() {
	echo "$@"
	"$@"
}

src_compile() {
	doecho $(tc-getCC) ${LDFLAGS} ${CFLAGS} cccp.c -o cccp \
		|| die "unable to build unpaper"
}

src_install () {
	dobin cccp
	doman cccp.1
	dodoc README TODO GETTING_STARTED scripts/SCRIPTS
	exeinto /usr/share/cccp/scripts
	doexe scripts/[a-z]*
}
