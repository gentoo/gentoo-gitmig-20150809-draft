# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/pyrpub/pyrpub-2.1.1.ebuild,v 1.1 2002/10/03 22:06:25 chouser Exp $

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
