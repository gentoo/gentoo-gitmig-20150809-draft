# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gptfdisk/gptfdisk-0.6.13.ebuild,v 1.1 2011/04/02 10:52:44 alexxy Exp $

EAPI="3"

inherit eutils toolchain-funcs

MY_PN="gdisk"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="gdisk - GPT partition table manipulator for Linux"
HOMEPAGE="http://www.rodsbooks.com/gdisk/"
SRC_URI="mirror://sourceforge/gptfdisk/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="
	!sys-apps/gdisk
"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	for x in gdisk sgdisk; do
		dosbin "${x}" || die
		doman "${x}.8" || die
		dohtml "${x}.html" || die
	done
	dodoc README NEWS
}
