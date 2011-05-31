# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfkickers/elfkickers-3.0.ebuild,v 1.1 2011/05/31 22:12:51 blueness Exp $

EAPI="4"

inherit eutils

MY_PF=${PF/elf/ELF}
S=${WORKDIR}/${MY_PF}

DESCRIPTION="collection of programs to manipulate ELF files: sstrip, rebind, elfls, elftoc"
HOMEPAGE="http://www.muppetlabs.com/~breadbox/software/elfkickers.html"
SRC_URI="http://www.muppetlabs.com/~breadbox/pub/software/${MY_PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-misc/pax-utils"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/create-destdir-path.patch
	sed -i -e "s:^prefix = /usr/local:prefix = ${D}:" Makefile
}
