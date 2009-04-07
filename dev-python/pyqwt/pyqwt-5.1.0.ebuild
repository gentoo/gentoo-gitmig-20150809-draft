# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyqwt/pyqwt-5.1.0.ebuild,v 1.1 2009/04/07 18:21:23 bicatali Exp $

EAPI=2
inherit eutils python toolchain-funcs

MY_P="PyQwt-${PV}"
S="${WORKDIR}/${MY_P}/configure"

DESCRIPTION="Python bindings for the Qwt library"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://pyqwt.sourceforge.net/"
SLOT="5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="debug doc examples svg"

RDEPEND="=x11-libs/qwt-5.1*[svg?]
	>=dev-python/PyQt4-4.2
	dev-python/numpy"
DEPEND="${DEPEND}
	>=dev-python/sip-4.6"

src_configure() {
	# the -j option can be buggy
	python_version
	"${python}" configure.py \
		--disable-numarray \
		--disable-numeric \
		-I/usr/include/qwt5 \
		-lqwt \
		|| die "python configure.py failed"
}

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
	cd ..
	dodoc ANNOUNCEMENT-${PV} CHANGES-${PV} README
	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r Doc/html || die
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins qt4examples/* || die
	fi
}
