# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/snpfile/snpfile-2.0.1.ebuild,v 1.1 2009/02/13 16:46:21 weaver Exp $

inherit eutils

DESCRIPTION="A library and API for manipulating large SNP datasets"
HOMEPAGE="http://www.birc.au.dk/~mailund/SNPFile/"
SRC_URI="http://www.birc.au.dk/~mailund/SNPFile/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}
