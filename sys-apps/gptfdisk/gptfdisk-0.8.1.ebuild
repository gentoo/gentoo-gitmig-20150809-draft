# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gptfdisk/gptfdisk-0.8.1.ebuild,v 1.2 2012/01/24 10:20:42 jlec Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="gdisk - GPT partition table manipulator for Linux"
HOMEPAGE="http://www.rodsbooks.com/gdisk/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x86-linux"
IUSE=""

DEPEND="
	dev-libs/icu"
RDEPEND=""

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	for x in gdisk sgdisk cgdisk fixparts; do
		dosbin "${x}"
		doman "${x}.8"
	done
	dodoc README NEWS
}
