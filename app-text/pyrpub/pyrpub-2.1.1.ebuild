# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pyrpub/pyrpub-2.1.1.ebuild,v 1.2 2002/10/04 20:33:10 vapier Exp $

P="pyrite-publisher-${PV}"
S=${WORKDIR}/${P}
DESCRIPTION="content conversion tool for Palm"
SRC_URI="http://www.pyrite.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.pyrite.org/publisher/"
LICENSE="GPL-2"
DEPEND="python"

src_compile() {
	python setup.py build || die "build failed"
}

src_install () {
	python setup.py install --root="${D}" || die "install failed"
	dodoc ChangeLog NEWS README* doc/*
}
