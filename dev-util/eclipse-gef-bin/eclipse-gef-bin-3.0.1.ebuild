# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-gef-bin/eclipse-gef-bin-3.0.1.ebuild,v 1.1 2005/03/19 21:19:13 luckyduck Exp $

inherit eclipse-ext

DESCRIPTION="The Graphical Editing Framework (GEF) allows developers to take an existing application model and easily create a rich graphical editor."
HOMEPAGE="http://www.eclipse.org/gef/"
SRC_URI="http://download.eclipse.org/tools/gef/downloads/drops/R-3.0.1-200408311615/GEF-runtime-3.0.1.zip"
SLOT="0"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~amd64"
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
