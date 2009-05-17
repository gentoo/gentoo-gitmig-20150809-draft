# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epsilon/epsilon-0.5.11.ebuild,v 1.5 2009/05/17 01:18:26 arfrever Exp $

EAPI="2"
inherit twisted distutils

DESCRIPTION="Epsilon is a Python utilities package, most famous for its Time class."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodEpsilon"
SRC_URI="http://divmod.org/trac/attachment/wiki/SoftwareReleases/Epsilon-${PV}.tar.gz?format=raw -> Epsilon-${PV}.tar.gz"
#SRC_URI="mirror://gentoo/Epsilon-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-2.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Epsilon-${PV}"

DOCS="NAME.txt NEWS.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Rename to avoid file-collisions
	mv bin/benchmark bin/epsilon-benchmark
	sed -i \
		-e "s#bin/benchmark#bin/epsilon-benchmark#" \
		setup.py || die "sed failed"
	# otherwise we get sandbox violations as it wants to update
	# the plugin cache
	epatch "${FILESDIR}/epsilon_plugincache_portagesandbox.patch"
}

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	# release tests needs DivmodCombinator
	rm epsilon/test/test_release.py*
	PYTHONPATH=. trial epsilon || die "tests failed"
}

pkg_postrm() {
	twisted_pkg_postrm
}

pkg_postinst() {
	twisted_pkg_postinst
}
