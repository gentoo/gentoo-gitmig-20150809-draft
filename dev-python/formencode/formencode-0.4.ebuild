# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/formencode/formencode-0.4.ebuild,v 1.3 2006/05/08 00:41:51 weeve Exp $

inherit distutils eutils

MY_PN="FormEncode"
DESCRIPTION="formencode is a validation and form generation package"
HOMEPAGE="http://formencode.org/"
SRC_URI="http://cheeseshop.python.org/packages/source/F/${MY_PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.3"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A} || die "Failed to unpack ${A}"
	cd ${S} || die "Failed to cd to ${S}"
	#We don't want to use setuptools until eggs.eclass is solid
	rm -rf ez_setup
	epatch ${FILESDIR}/${P}-setup-gentoo.patch
}

src_install() {
	distutils_src_install
	if use doc; then
		dodoc docs/*
		dodir /usr/share/doc/${PF}/examples
		cp -R examples/* ${D}/usr/share/doc/${PF}/examples
	fi
}

