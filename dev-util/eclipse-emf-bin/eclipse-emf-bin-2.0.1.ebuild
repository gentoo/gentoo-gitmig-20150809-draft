# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-emf-bin/eclipse-emf-bin-2.0.1.ebuild,v 1.2 2005/03/26 11:45:17 karltk Exp $

inherit eclipse-ext

DESCRIPTION="EMF is a modeling framework and code generation facility for building tools and other applications based on a structured data model."
HOMEPAGE="http://www.eclipse.org/emf/"
SRC_URI="http://download.eclipse.org/tools/emf/downloads/drops/2.0.1/R200409171617/emf-sdo-runtime-2.0.1.zip"
LICENSE="CPL-1.0"
SLOT="2"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.0.1
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
