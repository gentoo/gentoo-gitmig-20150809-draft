# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/mspdebug/mspdebug-0.13.ebuild,v 1.1 2010/11/26 07:53:55 radhermit Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="A free debugger for use with MSP430 MCUs"
HOMEPAGE="http://mspdebug.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="readline"

DEPEND="readline? ( sys-libs/readline )
	dev-libs/libusb:0"
RDEPEND="${DEPEND}"

src_compile() {
	local myflags

	if ! use readline; then
		myflags="WITHOUT_READLINE=1"
	fi

	emake CC=$(tc-getCC) ${myflags} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die "emake install failed"
	dodoc AUTHORS ChangeLog
}
