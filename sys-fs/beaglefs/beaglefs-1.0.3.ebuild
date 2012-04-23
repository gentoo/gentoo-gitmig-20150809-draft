# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/beaglefs/beaglefs-1.0.3.ebuild,v 1.5 2012/04/23 17:26:01 mgorny Exp $

inherit eutils

DESCRIPTION="beaglefs implements a filesystem representing a live Beagle query."
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/rml/fuse/beaglefs/"
SRC_URI="mirror://kernel/linux/kernel/people/rml/fuse/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-misc/beagle-0.2
	>=sys-fs/fuse-2.5"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if has_version dev-libs/libbeagle; then
		epatch "${FILESDIR}/${P}-libbeagle-0.3.patch"
	fi
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin beaglefs
	dodoc README
}

pkg_postinst() {
	einfo
	einfo "Please read README in /usr/share/doc/${P}"
	einfo "to learn how to work with beaglefs"
	einfo
}
