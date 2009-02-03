# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycipher/pycipher-0.2.ebuild,v 1.1 2009/02/03 19:55:22 patrick Exp $

inherit eutils python

DESCRIPTION="A Python module that implements several well-known classical cipher \
algorithms"
HOMEPAGE="http://pycipher.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.py"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/python"

src_install() {
		cd "${WORKDIR}"

		python_version
		exeinto "${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages"
		newexe "${DISTDIR}/${P}.py ${PN}.py"

		local dir="${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages"
		make_wrapper "${PN}" "python ./${PN}.py" "${dir}"
}
