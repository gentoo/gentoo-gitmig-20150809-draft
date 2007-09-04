# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython-docs/wxpython-docs-2.6.4.0.ebuild,v 1.1 2007/09/04 05:27:17 dirtyepic Exp $

inherit eutils

DESCRIPTION="wxPython documentation"
HOMEPAGE="http://www.wxpython.org"
SRC_URI="mirror://sourceforge/wxpython/wxPython-docs-${PV}.tar.bz2
	mirror://sourceforge/wxpython/wxPython-demo-${PV}.tar.bz2
	mirror://sourceforge/wxpython/wxPython-newdocs-${PV}.tar.bz2"

LICENSE="wxWinFDL-3 LGPL-2.1"
SLOT="2.6"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

S="${WORKDIR}/wxPython-${PV}"
DOCDIR="wxPython-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/demo-2.6.0.0-version.patch
	epatch "${FILESDIR}"/${P}-writable.patch
}

src_install() {
	dodir /usr/share/doc/${DOCDIR}/docs
	cp -R ${WORKDIR}/${DOCDIR}/docs/* ${D}/usr/share/doc/${DOCDIR}/docs/
	dodir /usr/share/doc/${DOCDIR}/demo
	dodir /usr/share/doc/${DOCDIR}/samples
	cp -R ${WORKDIR}/${DOCDIR}/demo/* ${D}/usr/share/doc/${DOCDIR}/demo/
	cp -R ${WORKDIR}/${DOCDIR}/samples/* ${D}/usr/share/doc/${DOCDIR}/samples/
	mv ${D}/usr/share/doc/${DOCDIR} ${D}/usr/share/doc/${PF}
}

pkg_postinst() {
	elog "The demo files are now included with dev-python/wxpython-docs."
	elog "The new-style documentation is in:"
	elog "/usr/share/doc/${PF}/docs/api\n"
	elog "The old-style documentation can still be accessed by running"
	elog "/usr/share/doc/${PF}/docs/viewdocs.py"
}
