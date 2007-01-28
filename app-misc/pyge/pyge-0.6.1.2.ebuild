# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pyge/pyge-0.6.1.2.ebuild,v 1.10 2007/01/28 05:23:12 genone Exp $

inherit eutils

MY_P=${P/pyge/PyGE}

S="${WORKDIR}/${MY_P}"
DESCRIPTION="Python Gutenberg E-text (PyGE) project, contains a Gutenberg E-text reader, and utilities for retrieval and compression."
HOMEPAGE="http://pyge.sourceforge.net"
SRC_URI="mirror://sourceforge/pyge/${MY_P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
DEPEND=">=dev-lang/python-2.1
	=dev-python/wxpython-2.4*"

src_install() {
	python setup.py install --root=${D} --prefix=/usr || die "setup.py install failed"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/help_file_location-${PV}.diff
	mv pygers.pyw pygers
	mv pygets.pyw pygets
	mv pygemz.pyw pygemz
	sed -i "s/.pyw//g" setup.py || die "Failed on sed setup.py"
}

pkg_postinst() {
	elog "You can find a sample database in /usr/share/pyge/gutenberg.xml"
	elog "For speech output you may optionally install app-accessibility/festival"
}

