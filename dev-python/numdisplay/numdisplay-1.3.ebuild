# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numdisplay/numdisplay-1.3.ebuild,v 1.1 2007/08/23 17:58:07 bicatali Exp $

inherit distutils

DESCRIPTION="Python package for interactively displaying FITS arrays"
SRC_URI="http://stsdas.stsci.edu/${PN}/download/${P}.tar"
HOMEPAGE="http://stsdas.stsci.edu/numdisplay/"

SLOT="0"

KEYWORDS="~amd64 ~x86"
LICENSE="AURA"
IUSE="doc"

DEPEND="virtual/python"
RDEPEND="${DEPEND}
	>=dev-python/numpy-1.0.1"


src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/copy_doc(data_dir, args)$/d' \
		setup.py || die "sed setup.py failed"
	sed -i \
		-e 's:/usr/local/lib:/etc:' \
		imconfig.py || die "sed imconfig.py failed"
}

src_install() {
	distutils_src_install
	insinto /etc
	doins imtoolrc || die "doins imtoolrc failed"
	if use doc; then
		einfo "Installing doc"
		insinto /usr/share/doc/${PF}
		doins doc/numdisplay.pdf || die "doins doc failed"
	fi
}
