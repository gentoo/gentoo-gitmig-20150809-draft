# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyinotify/pyinotify-0.8.6.ebuild,v 1.1 2009/06/15 16:48:18 deathwing00 Exp $

NEED_PYTHON="2.4"

inherit distutils

S="${WORKDIR}/${PN}"

DESCRIPTION="Python wrapper for inotify"
HOMEPAGE="http://trac.dbzteam.org/pyinotify"
SRC_URI="http://seb.dbzteam.org/pub/pyinotify/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc examples"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-libc-fix.patch
}

src_install() {
	cd python
	DOCS="NEWS"
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r src/examples
	fi

	if use doc; then
		dohtml -r doc/*
	fi
}

