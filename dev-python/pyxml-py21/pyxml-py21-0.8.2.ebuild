# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxml-py21/pyxml-py21-0.8.2.ebuild,v 1.1 2004/07/20 18:46:17 kloeri Exp $

PYTHON_SLOT_VERSION=2.1

MY_PN=${PN/pyxml/PyXML}

inherit distutils
P_NEW="${MY_PN%-py21}-${PV}"
S="${WORKDIR}/${P_NEW}"

DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${P_NEW}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="${DEPEND}
	>=dev-libs/expat-1.95.6"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="PYTHON"
IUSE=""

src_compile()
{
	local myconf

	# if you want to use 4Suite, then their XSLT/XPATH is
	# better according to the docs
	if has_version "dev-python/4Suite"; then
		myconf="--without-xslt --without-xpath"
	fi

	distutils_src_compile ${myconf}
}

src_install()
{
	mydoc="ANNOUNCE CREDITS PKG-INFO doc/*.tex"
	distutils_src_install

	dohtml -r doc/*
}
