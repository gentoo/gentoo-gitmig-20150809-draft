# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-ve-bin/eclipse-ve-bin-1.0.2.ebuild,v 1.1 2005/03/19 21:20:20 luckyduck Exp $

inherit eclipse-ext

DESCRIPTION="The Eclipse Visual Editor provides GUI builders for Eclipse."
HOMEPAGE="http://www.eclipse.org/vep/"
SRC_URI="http://download.eclipse.org/tools/ve/downloads/drops/R-1.0.2-200412091401/VE-runtime-1.0.2.zip"
SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.0.1
	=dev-util/eclipse-emf-bin-2.0.1
	=dev-util/eclipse-gef-bin-3.0.1
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
