# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfkickers/elfkickers-2.0a-r4.ebuild,v 1.3 2008/05/10 19:03:45 solar Exp $

inherit eutils multilib toolchain-funcs

MY_PN=${PN/elf/ELF}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="collection of programs to manipulate ELF files: sstrip, rebind, elfls, elftoc"
HOMEPAGE="http://www.muppetlabs.com/~breadbox/software/elfkickers.html"
SRC_URI="http://www.muppetlabs.com/~breadbox/pub/software/${MY_PN}-${PV}.tar.gz
	mirror://gentoo/elfkickers-2.0a-r2.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="doc"

DEPEND="app-misc/pax-utils"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/elfkickers-2.0a-r2.patch

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
		newdoc ${d}/README README.${d}
		dobin ${d}/${d}{32,64} || die "dobin ${d}{32,64} failed"
		doman $d/*.1
		case $(get_libdir) in
			lib64) dosym /usr/bin/${d}64 /usr/bin/${d};;
			lib|lib32) dosym /usr/bin/${d}32 /usr/bin/${d};;
		esac
	done
	dodoc Changelog README
}
