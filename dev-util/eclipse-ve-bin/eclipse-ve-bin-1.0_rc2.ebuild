# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-ve-bin/eclipse-ve-bin-1.0_rc2.ebuild,v 1.2 2004/11/03 11:45:34 axxo Exp $

inherit eclipse-ext

DESCRIPTION="The Eclipse Visual Editor provides GUI builders for Eclipse."
HOMEPAGE="http://www.eclipse.org/vep/"
SRC_URI="http://download.eclipse.org/tools/ve/downloads/drops/S-1.0M2-200407301410/VE-runtime-1.0M2.zip"
SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.0.0
	>=dev-util/eclipse-emf-bin-200403250631
	>=dev-util/eclipse-gef-bin-20040330
	app-arch/unzip"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_compile() {
	einfo "${P} is a binary package"
}

src_install () {
	eclipse-ext_require-slot 3

	eclipse-ext_create-ext-layout binary

	eclipse-ext_install-features eclipse/features/*
	eclipse-ext_install-plugins eclipse/plugins/*
}
