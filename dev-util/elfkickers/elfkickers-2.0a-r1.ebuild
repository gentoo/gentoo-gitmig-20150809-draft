# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfkickers/elfkickers-2.0a-r1.ebuild,v 1.4 2006/08/12 18:50:34 weeve Exp $

inherit eutils

MY_PN=${PN/elf/ELF}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="collection of programs to manipulate ELF files: sstrip, rebind, elfls, elftoc, ebfc"
HOMEPAGE="http://www.muppetlabs.com/~breadbox/software/elfkickers.html"
SRC_URI="http://www.muppetlabs.com/~breadbox/pub/software/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ~hppa ~mips ppc sparc x86"
IUSE="doc"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.diff
	epatch "${FILESDIR}"/${P}-elfls-core.patch
	epatch "${FILESDIR}"/${P}-make.patch
	epatch "${FILESDIR}"/${P}-bsd.patch

	cp "${FILESDIR}"/sstrip-mjn3.c sstrip/sstrip.c || die "failed to update sstrip"

	sed -i -e '/^SUBDIRS/s:tiny::' Makefile
	use x86 || sed -i -e '/^SUBDIRS/s:ebfc::' Makefile
}

src_install() {
	for d in elfls elftoc rebind sstrip ; do
		newdoc ${d}/README README.${d}
		dobin ${d}/${d} || die "dobin ${d} failed"
	done
	if use x86 ; then
		newdoc ebfc/README README.ebfc
		dobin ebfc/ebfc || die "dobin ebfc failed"
	fi

	doman */*.1
	dodoc Changelog README ebfc/elfparts.txt
	if use doc ; then
		docinto tiny
		dodoc tiny/*.asm
	fi
}
