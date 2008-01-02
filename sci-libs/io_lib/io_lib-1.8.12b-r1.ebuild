# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/io_lib/io_lib-1.8.12b-r1.ebuild,v 1.4 2008/01/02 16:21:20 armin76 Exp $

DESCRIPTION="A general purpose trace and experiment file reading/writing interface"
HOMEPAGE="http://staden.sourceforge.net/"
SRC_URI="mirror://sourceforge/staden/${P}.tar.bz2"
LICENSE="staden"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

S="${WORKDIR}/${PN}-1.8.12"

src_install() {
	make install DESTDIR="${D}" || die

	insinto /usr/include/${PN}
	doins "${S}"/{config,os}.h || die "Failed to install config.h header"

	dodoc CHANGES README || die "Failed to install documentation."
}
