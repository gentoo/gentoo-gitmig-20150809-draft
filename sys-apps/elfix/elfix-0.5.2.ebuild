# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/elfix/elfix-0.5.2.ebuild,v 1.12 2012/09/30 17:24:52 armin76 Exp $

EAPI="4"

DESCRIPTION="Tools to work with ELF binaries and libraries on Hardened Gentoo."
HOMEPAGE="http://dev.gentoo.org/~blueness/elfix/"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="test xtpax"

DEPEND="
	dev-libs/elfutils
	=dev-python/pypax-${PV}[xtpax=]
	xtpax? ( sys-apps/attr )"

RDEPEND="${DEPEND}"

src_configure() {
	rm -f "${S}/scripts/setup.py"
	econf $(use_enable test tests)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog INSTALL README THANKS TODO
}
