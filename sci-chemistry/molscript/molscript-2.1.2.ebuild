# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molscript/molscript-2.1.2.ebuild,v 1.6 2010/09/16 17:27:21 scarabeus Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Display molecular 3D structures, such as proteins, in both schematic and detailed representations."
HOMEPAGE="http://www.avatar.se/molscript/"
SRC_URI="${P}.tar.gz"
LICENSE="glut molscript"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
RESTRICT="fetch"
IUSE=""
DEPEND="media-libs/jpeg
	media-libs/libpng
	media-libs/gd
	media-libs/freeglut
	|| (	x11-libs/libXmu
			x11-libs/libXext
			x11-libs/libX11	)"
RDEPEND="${DEPEND}"

pkg_nofetch() {
	elog "Please visit ${HOMEPAGE}"
	elog "and get ${A}."
	elog "Place it in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/fix-makefile-shared.patch

	# Provide glutbitmap.h, because freeglut doesn't have it
	cp ${FILESDIR}/glutbitmap.h ${S}/clib/

	# Stop an incredibly hacky include
	sed -i -e 's:<../lib/glut/glutbitmap.h>:"glutbitmap.h":g' \
		${S}/clib/ogl_bitmap_character.c
}

src_compile() {
	# Prefix of programs it links with
	export FREEWAREDIR="/usr"

	ln -s Makefile.complete Makefile

	# Honor CC and CFLAGS  from environment;
	# unfortunately a bash bug prevents us from doing typeset and
	# assignment on the same line.
	typeset -a args
	args=( CC="$(tc-getCC)" \
		COPT="${CFLAGS}" )

	emake "${args[@]}" || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe molscript molauto
	dohtml ${S}/doc/*.html
}
