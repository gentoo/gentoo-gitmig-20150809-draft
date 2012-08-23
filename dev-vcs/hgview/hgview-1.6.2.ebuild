# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hgview/hgview-1.6.2.ebuild,v 1.1 2012/08/23 01:05:34 pesa Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

DESCRIPTION="PyQt4-based Mercurial log navigator"
HOMEPAGE="http://www.logilab.org/project/hgview"
SRC_URI="http://ftp.logilab.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/docutils
	dev-python/egenix-mx-base
	dev-python/PyQt4[X]
	dev-python/qscintilla-python
	dev-vcs/mercurial
	doc? ( app-text/asciidoc )"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="hgext/hgview.py hgviewlib"

src_prepare() {
	distutils_src_prepare

	# Fix mercurial extension install path.
	if ! use doc; then
		sed -e '/make -C doc/d' -i setup.py || die
		sed -e '/share\/man\/man1/,+1 d' -i hgviewlib/__pkginfo__.py || die
	fi
}

src_install() {
	distutils_src_install

	# Install the mercurial extension config.
	insinto /etc/mercurial/hgrc.d
	doins "${FILESDIR}"/hgview.rc
}
