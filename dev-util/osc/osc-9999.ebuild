# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/osc/osc-9999.ebuild,v 1.4 2012/10/02 11:01:59 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/openSUSE/osc.git"

if [[ "${PV}" == "9999" ]]; then
	EXTRA_ECLASS="git-2"
else
	OBS_PROJECT="openSUSE:Tools"
	EXTRA_ECLASS="obs-download"
fi

inherit distutils ${EXTRA_ECLASS}
unset EXTRA_ECLASS

DESCRIPTION="Command line tool for Open Build Service"
HOMEPAGE="http://en.opensuse.org/openSUSE:OSC"

[[ "${PV}" == "9999" ]] || SRC_URI="${OBS_URI}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
[[ "${PV}" == "9999" ]] || KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/urlgrabber
	dev-python/pyxml
	dev-python/elementtree
	app-arch/rpm[python]
	dev-python/m2crypto
"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	dosym osc-wrapper.py /usr/bin/osc
	keepdir /usr/lib/osc/source_validators
	cd "${ED}"/usr/
	find . -type f -exec sed -i 's|/usr/bin/build|/usr/bin/suse-build|g'   {} +
	find . -type f -exec sed -i 's|/usr/lib/build|/usr/share/suse-build|g' {} +
	rm -f "${ED}"/usr/share/doc/${PN}*/TODO*
}
