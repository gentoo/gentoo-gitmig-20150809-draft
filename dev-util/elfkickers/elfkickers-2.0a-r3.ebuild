# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfkickers/elfkickers-2.0a-r3.ebuild,v 1.1 2007/08/30 14:12:08 pva Exp $

inherit eutils

MY_PN=${PN/elf/ELF}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="collection of programs to manipulate ELF files: sstrip, rebind, elfls, elftoc, ebfc"
HOMEPAGE="http://www.muppetlabs.com/~breadbox/software/elfkickers.html"
SRC_URI="http://www.muppetlabs.com/~breadbox/pub/software/${MY_PN}-${PV}.tar.gz
	mirror://gentoo/elfkickers-2.0a-r2.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/elfkickers-2.0a-r2.patch

	sed -i -e '/^SUBDIRS/s:tiny::' Makefile
	use x86 || sed -i -e '/^SUBDIRS/s:ebfc::' Makefile
	use x86 && sed -i -e 's:linux/elf.h:elf.h:' ebfc/*.c
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
