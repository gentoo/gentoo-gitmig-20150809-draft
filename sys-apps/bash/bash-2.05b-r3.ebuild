# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bash/bash-2.05b-r3.ebuild,v 1.1 2002/09/25 11:15:41 azarah Exp $

inherit flag-o-matic

# Official patches
PLEVEL="x002 x003 x004"

S=${WORKDIR}/${P}
DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="ftp://ftp.gnu.org/gnu/bash/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2
	${PLEVEL//x/ftp://ftp.gnu.org/gnu/bash/bash-${PV}-patches/bash${PV/\.}-}"
HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.2-r2 
	sys-devel/autoconf"

src_unpack() {
	unpack ${P}.tar.gz ${P}-gentoo.diff.bz2
	
	cd ${S}
	patch -p1 < ${WORKDIR}/${P}-gentoo.diff || die
	for x in ${PLEVEL//x}
	do
		patch -p0 < ${DISTDIR}/${PN}${PV/\.}-${x} || die
	done
}

src_compile() {

	filter-flags -malign-double

	local myconf=""

	# Always use the buildin readline, else if we update readline
	# bash gets borked as readline is usually not binary compadible
	# between minor versions.
	#
	# Martin Schlemmer <azarah@gentoo.org> (1 Sep 2002)
	#use readline && myconf="--with-installed-readline"
	
	use nls || myconf="${myconf} --disable-nls"

	econf \
		--disable-profiling \
		--with-curses \
		--without-gnu-malloc \
		${myconf} || die

	make || die
}

src_install() {

	einstall || die

	dodir /bin
	mv ${D}/usr/bin/bash ${D}/bin
	dosym bash /bin/sh

	use build \
		&& rm -rf ${D}/usr \
		|| ( \
			doman doc/*.1 doc/*.3
			dodoc README NEWS AUTHORS CHANGES COMPAT COPYING Y2K
			dodoc doc/FAQ doc/INTRO
		)
}

