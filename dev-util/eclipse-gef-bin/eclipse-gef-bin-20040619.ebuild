# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-gef-bin/eclipse-gef-bin-20040619.ebuild,v 1.2 2004/11/03 11:45:04 axxo Exp $

inherit eclipse-ext

DESCRIPTION="The Graphical Editing Framework (GEF) allows developers to take an existing application model and easily create a rich graphical editor."
HOMEPAGE="http://www.eclipse.org/gef/"
SRC_URI="http://download.eclipse.org/tools/gef/downloads/drops/S-3.0RC3-200406191500/GEF-runtime-I20040619.zip"
SLOT="0"
LICENSE="CPL-1.0"
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

	eclipse-ext_install-features eclipse/features/*
	eclipse-ext_install-plugins eclipse/plugins/*
}
