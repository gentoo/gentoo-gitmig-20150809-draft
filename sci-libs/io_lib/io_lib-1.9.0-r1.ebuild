# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/io_lib/io_lib-1.9.0-r1.ebuild,v 1.1 2006/09/30 02:41:07 ribosome Exp $

DESCRIPTION="A general purpose trace and experiment file reading/writing interface"
HOMEPAGE="http://staden.sourceforge.net/"
SRC_URI="mirror://sourceforge/staden/${P}.tar.bz2"
LICENSE="staden"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

# Prototype changes in io_lib-1.9.0 create incompatibilities with BioPerl. (Only
# versions 1.8.11 and 1.8.12 will work with the BioPerl Staden extensions.)
DEPEND="!sci-biology/bioperl"
RDEPEND="${DEPEND}"

src_install() {
	make install DESTDIR="${D}" || die

	insinto /usr/include/${PN}
	doins "${S}"/config.h || die "Failed to install config.h header"

	dodoc CHANGES README || die "Failed to install documentation."
}
