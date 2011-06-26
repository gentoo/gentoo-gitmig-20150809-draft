# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/probe/probe-2.12.110413.ebuild,v 1.2 2011/06/26 08:48:58 jlec Exp $

EAPI=4

inherit eutils toolchain-funcs

MY_P="${PN}.${PV}"

DESCRIPTION="Evaluates atomic packing within or between molecules"
HOMEPAGE="http://kinemage.biochem.duke.edu/software/probe.php"
SRC_URI="http://kinemage.biochem.duke.edu/downloads/software/probe/${MY_P}.src.zip"

LICENSE="richardson"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/trunk

src_prepare() {
	epatch "${FILESDIR}"/${PV}-as-needed.patch
	# Respect CC
	sed -i \
		-e 's:cc:$(CC):g' \
		"${S}"/Makefile || die
	tc-export CC
}

src_install() {
	dobin "${S}"/probe
	dodoc "${S}"/README*
}
