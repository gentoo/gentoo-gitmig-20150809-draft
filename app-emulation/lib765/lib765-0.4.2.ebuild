# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/lib765/lib765-0.4.2.ebuild,v 1.3 2011/12/18 20:11:58 phajdan.jr Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Floppy controller emulator"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="libdsk static-libs"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="libdsk? ( app-emulation/libdsk )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_with libdsk) $(use_enable static-libs static) || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog doc/765.txt
}
