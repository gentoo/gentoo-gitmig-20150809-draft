# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aap/aap-1.010.ebuild,v 1.1 2003/08/15 13:39:46 agriffis Exp $

IUSE=""

DESCRIPTION="Bram Moolenaar's super-make program"
HOMEPAGE="http://www.a-a-p.org/"
SRC_URI="mirror://sourceforge/a-a-p/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~x86"
DEPEND="app-arch/unzip"
RDEPEND=">=dev-lang/python-1.5"
S=${WORKDIR}/${PN}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unzip ${DISTDIR}/${A}
}

src_install() {
	# Install the documentation
	rm doc/*.sgml
	dohtml doc/*.html
	rm doc/*.html
	dodoc doc/*
	doman aap.1
	rm -rf doc aap.1

	# Move the remainder directly into the dest tree
	dodir /usr/share
	cd ${WORKDIR}
	mv aap ${D}/usr/share

	# Create a symbolic link for the executable
	dodir /usr/bin
	ln -s ../share/aap/aap ${D}/usr/bin/aap
}
