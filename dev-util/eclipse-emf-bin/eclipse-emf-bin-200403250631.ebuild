# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-emf-bin/eclipse-emf-bin-200403250631.ebuild,v 1.4 2004/11/03 11:43:32 axxo Exp $

inherit eclipse-ext

DESCRIPTION="EMF is a modeling framework and code generation facility for building tools and other applications based on a structured data model."
HOMEPAGE="http://www.eclipse.org/emf/"
SRC_URI="http://download.eclipse.org/tools/emf/downloads/drops/2.0/I200403250631/emf-runtime-I200403250631.zip"
LICENSE="CPL-1.0"
SLOT="2"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.0.0_pre8
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

	eclipse-ext_install-features features/*
	eclipse-ext_install-plugins plugins/*
}
