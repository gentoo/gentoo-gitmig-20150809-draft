# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/imediff2/imediff2-1.1.2.ebuild,v 1.1 2007/10/31 09:34:01 dev-zero Exp $

inherit eutils versionator

KEYWORDS="~amd64 ~x86"

MY_P=${PN}_$(replace_version_separator 3 -)

DESCRIPTION="An interactive, user friendly 2-way merge tool in text mode."
HOMEPAGE="http://elonen.iki.fi/code/imediff/"
SRC_URI="http://alioth.debian.org/frs/download.php/1439/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	if ! built_with_use --missing true dev-lang/python ncurses ; then
		eerror "dev-lang/python has to be built with ncurses support"
		die "Missing ncurses USE-flag for dev-lang/python"
	fi
}

src_compile() {
	# Otherwise the docs get regenerated :)
	einfo "Nothing to compile..."
}

src_install() {
	dobin imediff2
	dodoc AUTHORS README
	doman imediff2.1
}
