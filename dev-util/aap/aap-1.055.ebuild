# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aap/aap-1.055.ebuild,v 1.1 2004/02/15 23:31:31 agriffis Exp $

IUSE=""

DESCRIPTION="Bram Moolenaar's super-make program"
HOMEPAGE="http://www.a-a-p.org/"
SRC_URI="mirror://sourceforge/a-a-p/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ia64 ~x86"
DEPEND="app-arch/unzip"
RDEPEND=">=dev-lang/python-1.5"
S=${WORKDIR}/${PN}

src_unpack() {
	mkdir ${S} && cd ${S} && unzip -q ${DISTDIR}/${A} || die
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
