# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bash/bash-2.05b.ebuild,v 1.4 2002/08/30 16:06:12 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="ftp://ftp.gnu.org/gnu/bash/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.2-r2 
	readline? ( >=sys-libs/readline-4.1-r2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	#enable non-interactive login shells; this patch allows your prompt 
	#to be preserved when you start X and closes bug #1579.
#	cat ${FILESDIR}/config-top.h.diff | patch -p0 -l || die
}

src_compile() {

	local myconf
	use readline && myconf="--with-installed-readline"
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
			doman doc/*.1
			use readline || doman doc/*.3
			dodoc README NEWS AUTHORS CHANGES COMPAT COPYING Y2K
			dodoc doc/FAQ doc/INTRO
		)
}
