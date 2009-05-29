# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/probe/probe-2.12.071128.ebuild,v 1.3 2009/05/29 00:44:23 dberkholz Exp $

inherit toolchain-funcs

MY_P="${PN}.${PV}"
DESCRIPTION="Evaluates atomic packing within or between molecules"
HOMEPAGE="http://kinemage.biochem.duke.edu/software/probe.php"
SRC_URI="http://kinemage.biochem.duke.edu/downloads/software/probe/${MY_P}.src.zip"
LICENSE="richardson"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"
S="${WORKDIR}/${MY_P}.scr"

src_unpack() {
	unpack ${A}

	# Respect CC
	sed -i \
		-e 's:cc:$(CC):g' \
		"${S}"/Makefile
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		MACHINEFLAGS="${LDFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin "${S}"/probe
	dodoc "${S}"/README*
}
