# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mxmlplus/mxmlplus-0.9.2.ebuild,v 1.1 2004/11/07 11:27:40 usata Exp $

inherit eutils

MY_P="lib${P}"

DESCRIPTION="MXMLPlus is a C++ library based on the engine of MXML (but integrated with stl:: classes) that merges the power and DOM concepts you find in MXML with a real object oriented environment."

SRC_URI="mirror://sourceforge/mxml/${MY_P}.tar.gz"
HOMEPAGE="http://mxml.sourceforge.net/"

DEPEND="doc? ( app-doc/doxygen )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fixblanks.patch
}

src_compile() {
	econf --enable-shared $(use_enable doc) || die
	emake || die

	if use doc; then
		cd ${S}/doc
		doxygen
	fi
}

src_install () {
	make DESTDIR=${D} install || die

	if use doc; then
		dodir /usr/share/doc/${PF}
		dohtml -r ${S}/doc/html/*
	fi
}
