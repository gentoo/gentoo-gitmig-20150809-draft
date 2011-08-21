# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfkickers/elfkickers-2.0a-r5.ebuild,v 1.2 2011/08/21 16:11:12 xarthisius Exp $

inherit eutils multilib toolchain-funcs

MY_PN=${PN/elf/ELF}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="collection of programs to manipulate ELF files: sstrip, rebind, elfls, elftoc"
HOMEPAGE="http://www.muppetlabs.com/~breadbox/software/elfkickers.html"
SRC_URI="http://www.muppetlabs.com/~breadbox/pub/software/${MY_PN}-${PV}.tar.gz
	mirror://gentoo/elfkickers-2.0a-r5.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="app-misc/pax-utils"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/elfkickers-2.0a-r5.patch

	sed -i -e '/^SUBDIRS/s:tiny::' Makefile
	use x86 || sed -i -e '/^SUBDIRS/s:ebfc::' Makefile
	use x86 && sed -i -e 's:linux/elf.h:elf.h:' ebfc/*.c
	(cd tiny && make clean)
}

src_compile() {
	for bits in 32 64; do
		emake CC=$(tc-getCC) CFLAGS="-DELF_CLASS=ELFCLASS${bits} ${CFLAGS}" clean all
		for x in elfls elftoc rebind sstrip; do
			mv ${x}/$x{,${bits}} || die "moving failed of ${x}{,${bits}"
		done
	done
}

src_install() {
	for d in elfls elftoc rebind sstrip ; do
		newdoc ${d}/README README.${d} || die
		dobin ${d}/${d}{32,64} || die
		for i in ${d}/*.1; do
		  [ -e ${i} ] && doman ${i}
		done
		case $(get_libdir) in
			lib64) dosym /usr/bin/${d}64 /usr/bin/${d};;
			lib|lib32) dosym /usr/bin/${d}32 /usr/bin/${d};;
		esac
	done
	dodoc Changelog README || die
}
