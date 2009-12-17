# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hgview/hgview-1.1.3.ebuild,v 1.2 2009/12/17 22:58:54 spatz Exp $

EAPI="2"

inherit distutils

DESCRIPTION="PyQt4 based Mercurial log navigator"
HOMEPAGE="http://www.logilab.org/project/name/hgview"
SRC_URI="http://ftp.logilab.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-util/mercurial
	dev-python/egenix-mx-base
	dev-python/PyQt4[X]
	dev-python/qscintilla-python
	dev-python/docutils
	doc? ( app-text/asciidoc )"
RDEPEND="${DEPEND}"

src_prepare() {
	distutils_src_prepare

	if ! use doc; then
		sed -i '/make -C doc/d' "${S}/setup.py" || die "sed failed"
		sed -i '/share\/man\/man1/,+1 d' "${S}/hgviewlib/__pkginfo__.py" || die "sed failed"
	fi
}

src_install() {
	distutils_src_install

	# install the mercurial extension config
	insinto /etc/mercurial/hgrc.d || die
	doins hgext/hgview.rc || die
}
