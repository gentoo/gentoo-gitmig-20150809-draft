# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcal/libmcal-0.7.ebuild,v 1.2 2003/09/08 07:19:26 msterret Exp $

DESCRIPTION="Modular Calendar Access Libary"
HOMEPAGE="http://mcal.chek.com/"
SRC_URI="mirror://sourceforge/libmcal/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

# Have only tested on x86, but I suppose it should work on all platforms
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips"

IUSE=""
DEPEND=""
RDEPEND=""
S=${WORKDIR}/${PN}

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc CHANGELOG FAQ-MCAL FEATURE-IMPLEMENTATION HOW-TO-MCAL LICENSE README
	dohtml FUNCTION-REF.html
}
