# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.12.ebuild,v 1.9 2004/12/07 02:43:53 caleb Exp $

inherit distutils

IUSE="doc"

MY_P="PyQt-x11-gpl-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="set of Python bindings for the QT 3.x Toolkit"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc -alpha amd64"

RDEPEND="virtual/libc
	x11-libs/qt
	dev-lang/python
	>=dev-python/sip-3.10.2
	<=dev-python/qscintilla-1.60"

DEPEND="${RDEPEND}
	sys-devel/libtool"


src_compile() {
	distutils_python_version
	addpredict ${QTDIR}/etc/settings
	sed -i -e "s/  check_license()/# check_license()/" configure.py
	python configure.py \
		-d /usr/lib/python${PYVER}/site-packages \
		-b /usr/bin \
		-v /usr/share/sip \
		-c
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc ChangeLog LICENSE NEWS README README.Linux THANKS
	use doc && ( dohtml doc/PyQt.html
			dodir /usr/share/doc/${PF}/examples
			cp -r examples3/* ${D}/usr/share/doc/${PF}/examples )
}
