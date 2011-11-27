# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/elfix/elfix-0.3.2.ebuild,v 1.2 2011/11/27 03:16:57 blueness Exp $

EAPI=4

DESCRIPTION="Tools to fix ELF binaries to work on Hardened Gentoo"
HOMEPAGE="http://dev.gentoo.org/~blueness/elfix/"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-libs/elfutils
	=dev-python/pypax-0.3*
	test? ( dev-lang/yasm )"
RDEPEND="${DEPEND}"

src_configure() {
	rm -f "${S}/scripts/setup.py"
	econf $(use_enable test tests)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog INSTALL README THANKS TODO
}
