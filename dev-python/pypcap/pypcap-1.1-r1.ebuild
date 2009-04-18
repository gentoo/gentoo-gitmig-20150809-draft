# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypcap/pypcap-1.1-r1.ebuild,v 1.1 2009/04/18 14:24:14 patrick Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Simplified object-oriented Python extension module for libpcap"
HOMEPAGE="http://code.google.com/p/pypcap/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="virtual/libpcap"
DEPEND="${RDEPEND}
	>=dev-python/pyrex-0.9.5.1a"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/include_path.patch" || die
}

src_compile() {
	# pcap.c was generated with pyrex-0.9.3
	# and <=pyrex-0.9.5.1a is incompatible with python-2.5.
	# So we regenerate it. Bug #180039
	pyrexc pcap.pyx || die "pyrexc failed"
	"${python}" setup.py config || die "config failed"
	distutils_src_compile
}

src_install() {
	DOCS="CHANGES"
	distutils_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins testsniff.py
	fi
}

src_test() {
	# PYTHONPATH is set correctly in the test itself
	"${python}" test.py || die "tests failed"
}
