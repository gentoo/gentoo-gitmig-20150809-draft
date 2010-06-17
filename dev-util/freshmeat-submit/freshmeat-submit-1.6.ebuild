# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freshmeat-submit/freshmeat-submit-1.6.ebuild,v 1.5 2010/06/17 10:53:41 jlec Exp $

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="A utility for submitting version updates to freshmeat.net, designed to run from within a project release script, using freshmeat.net's XML- RPC interface"
HOMEPAGE="http://www.catb.org/~esr/freshmeat-submit/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs 2 ${PN}
}

src_compile() { :; }

src_install() {
	doman ${PN}.1 || die "doman failed"
	dodoc AUTHORS README || die "dodoc failed"
	dobin ${PN} || die "dobin failed"
}
