# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gdisk/gdisk-0.6.13.ebuild,v 1.1 2010/10/28 05:23:36 radhermit Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="gdisk - GPT partition table manipulator for Linux"
HOMEPAGE="http://www.rodsbooks.com/gdisk/"
SRC_URI="mirror://sourceforge/gptfdisk/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

RDEPEND=""

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
