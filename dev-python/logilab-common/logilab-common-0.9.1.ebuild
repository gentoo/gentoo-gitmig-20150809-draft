# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.9.1.ebuild,v 1.2 2005/03/29 02:10:37 vapier Exp $

inherit distutils

DESCRIPTION="Several modules providing low level functionality shared among some python projects developed by logilab."
HOMEPAGE="http://www.logilab.org/projects/common/"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P#logilab-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~x86"
IUSE="doc"

DEPEND=""

S=${WORKDIR}/${P#logilab-}

PYTHON_MODNAME="logilab"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/*
	fi
}
