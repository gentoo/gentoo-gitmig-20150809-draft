# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rsstool/rsstool-1.0.1_rc2.ebuild,v 1.1 2010/09/18 11:25:31 vapier Exp $

EAPI="2"

inherit eutils

MY_PV=${PV/_}
MY_P=${PN}-${MY_PV}

DESCRIPTION="cmdline tool to read, parse, merge, and write RSS (and Atom) feeds"
HOMEPAGE="http://rsstool.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${MY_P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}-src/src

src_prepare() {
	sed -i '1i#!/bin/bash' configure #141906
}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" install || die
	dohtml ../*.html
}
