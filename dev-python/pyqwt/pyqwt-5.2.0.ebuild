# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyqwt/pyqwt-5.2.0.ebuild,v 1.2 2010/01/11 17:07:12 arfrever Exp $

EAPI=2

inherit python flag-o-matic

MY_P="PyQwt-${PV}"
DESCRIPTION="Python bindings for the Qwt library"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://pyqwt.sourceforge.net/"

SLOT="5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="debug doc examples svg"

RDEPEND=">=x11-libs/qwt-5.1[svg?]
	dev-python/PyQt4
	dev-python/numpy"
DEPEND="${DEPEND}
	dev-python/sip"

RESTRICT_PYTHON_ABIS="2.4 2.7 3.*"

S="${WORKDIR}/${MY_P}/configure"

src_configure() {

	append-flags -fPIC

	# the -j option can be buggy
	python_version
	"${python}" configure.py \
		--disable-numarray \
		--disable-numeric \
		-I/usr/include/qwt5 \
		-lqwt \
		|| die "python configure.py failed"

	# avoiding strip the libraries
	sed -i -e '/strip/d' {iqt5qt4,qwt5qt4}/Makefile || die "sed failed"
}

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
	cd ..
	dodoc ANNOUNCEMENT-${PV} README
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r sphinx/build/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins qt4examples/* || die
	fi
}
