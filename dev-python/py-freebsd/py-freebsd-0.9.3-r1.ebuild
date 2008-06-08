# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-freebsd/py-freebsd-0.9.3-r1.ebuild,v 1.1 2008/06/08 19:25:43 the_paya Exp $

inherit distutils

DESCRIPTION="Python interface to FreeBSD-specific system libraries"
HOMEPAGE="http://www.freebsd.org/cgi/cvsweb.cgi/ports/devel/py-freebsd/"
SRC_URI="mirror://freebsd/ports/local-distfiles/perky/${P}.tar.gz
	http://people.freebsd.org/~perky/distfiles/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="sys-freebsd/freebsd-lib
	dev-lang/python"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/fbsd7-netstat.patch"
	epatch "${FILESDIR}/process-fix.patch"
}

src_test() {
	mkdir "${T}/tests"
	"${python}" setup.py install --home="${T}/tests"

	export PYTHONPATH="${T}/tests/$(get_libdir)/python"
	"${python}" "${S}/tests/test_kqueue.py" || die "test_kqueue failed"
	"${python}" "${S}/tests/test_sysctl.py" || die "test_sysctl failed"

	rm -rf "${T}/tests"
}
