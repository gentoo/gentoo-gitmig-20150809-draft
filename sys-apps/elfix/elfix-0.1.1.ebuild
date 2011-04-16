# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/elfix/elfix-0.1.1.ebuild,v 1.1 2011/04/16 23:32:43 blueness Exp $

EAPI=3

DESCRIPTION="Tool to query or clear the ELF GNU_STACK executable flag"
HOMEPAGE="http://dev.gentoo.org/~blueness/elfix/"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/elfutils
	test? ( dev-lang/yasm )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable test tests)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL README THANKS TODO
}
