# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.9.1.ebuild,v 1.1 2005/03/19 04:40:48 fserb Exp $

inherit distutils

DESCRIPTION="Several modules providing low level functionality shared among some python projects developed by logilab."
SRC_URI="ftp://ftp.logilab.org/pub/common/${P#logilab-}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/common/"

SLOT="0"
KEYWORDS="~x86 ~s390 ~ppc ~amd64"
LICENSE="GPL-2"
DEPEND=""
IUSE="doc"

S=${WORKDIR}/${P#logilab-}

PYTHON_MODNAME="logilab"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/*
	fi
}