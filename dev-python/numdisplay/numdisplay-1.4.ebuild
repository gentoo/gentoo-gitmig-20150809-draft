# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numdisplay/numdisplay-1.4.ebuild,v 1.1 2008/06/26 14:29:48 bicatali Exp $

inherit distutils versionator

MY_P=${PN}_v$(replace_version_separator 1 '' )

DESCRIPTION="Python package for interactively displaying FITS arrays"
SRC_URI="http://stsdas.stsci.edu/${PN}/download/${MY_P}.tar"
HOMEPAGE="http://stsdas.stsci.edu/numdisplay/"

SLOT="0"

KEYWORDS="~amd64 ~x86"
LICENSE="AURA"
IUSE="doc"

DEPEND="virtual/python"
RDEPEND="dev-python/numpy"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
	   -e '/data_files/d' \
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
		einfo "Installing docs"
		insinto /usr/share/doc/${PF}
		doins doc/*.pdf || die "doins doc failed"
	fi
}
