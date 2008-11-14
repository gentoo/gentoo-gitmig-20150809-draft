# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amara/amara-1.2.0.2.ebuild,v 1.1 2008/11/14 03:31:29 marineam Exp $

inherit distutils

MY_P=${P/amara/Amara}

DESCRIPTION="Python tools for XML processing."
HOMEPAGE="http://uche.ogbuji.net/tech/4suite/amara/"
SRC_URI="ftp://ftp.4suite.org/pub/Amara/${MY_P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

RDEPEND=">=dev-python/4suite-1.0.2"
DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We would get 'unknown module amara' if amara is not yet installed
	ln -s lib amara
}

src_install() {
	distutils_src_install

	dodoc ACKNOWLEDGEMENTS CHANGES README TODO quickref.txt
	dohtml manual.html

	if use doc; then
		epydoc build/lib/amara && dohtml -r html/*
	fi

	if use examples; then
		insinto /usr/share/${PN}
		doins -r demo
	fi
}
