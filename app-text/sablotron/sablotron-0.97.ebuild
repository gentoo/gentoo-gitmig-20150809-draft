# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.97.ebuild,v 1.4 2003/04/16 06:47:14 taviso Exp $

S=${WORKDIR}/Sablot-${PV}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://download-2.gingerall.cz/download/sablot/Sablot-${PV}.tar.gz"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 ~sparc ~ppc ~hppa ~alpha"

DEPEND=">=dev-libs/expat-1.95.1
	dev-perl/XML-Parser"

src_compile() {
	local myconf
	use perl && myconf="--enable-perlconnect"

	# rphillips
	# fixes bug #3876
	export LDFLAGS="-lstdc++"

	econf ${myconf}
	make || die
}

src_install() {
	einstall
	dodoc README* RELEASE
	dodoc src/TODO
}
