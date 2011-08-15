# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/osc/osc-9999.ebuild,v 1.2 2011/08/15 09:02:09 miska Exp $

EAPI=3

EGIT_REPO_URI="git://gitorious.org/opensuse/osc.git"

[[ "${PV}" == "9999" ]] && EXTRA_ECLASS="git-2"
inherit distutils ${EXTRA_ECLASS}
unset EXTRA_ECLASS

DESCRIPTION="Command line tool for Open Build Service"
HOMEPAGE="http://en.opensuse.org/openSUSE:OSC"

[[ "${PV}" == "9999" ]] || SRC_URI="https://api.opensuse.org/public/source/openSUSE:11.4/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
[[ "${PV}" == "9999" ]] || KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/urlgrabber
	dev-python/pyxml
	dev-python/elementtree
	app-arch/rpm[python]
	dev-python/m2crypto"
RDEPEND="${DEPEND}
	dev-util/suse-build"

src_install() {
	distutils_src_install
	dosym osc-wrapper.py /usr/bin/osc || \
		die "Creating /usr/bin/osc failed"
	keepdir /usr/lib/osc/source_validators    || \
		die "Creating /usr/lib/osc/source_validators failed"
	cd "${ED}"/usr/
	find . -exec grep -l /usr/bin/build \{\} \; | while read i; do
		sed -i 's|/usr/bin/build|/usr/bin/suse-build|g'   "${i}" \
			|| die "sed for /usr/${i} failed"
	done
	find . -exec grep -l /usr/lib/build \{\} \; | while read i; do
		sed -i 's|/usr/lib/build|/usr/share/suse-build|g' "${i}" \
			|| die "sed for /usr/${i} failed"
	done
	rm -f "${ED}"/usr/share/doc/${PN}*/TODO*
}
