# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bash/bash-2.05a-r2.ebuild,v 1.4 2002/05/08 00:06:18 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="ftp://ftp.gnu.org/gnu/bash/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

DEPEND=">=sys-libs/ncurses-5.2-r2 readline? ( >=sys-libs/readline-4.1-r2 )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	#enable non-interactive login shells; this patch allows your prompt 
	#to be preserved when you start X and closes bug #1579.
	cat ${FILESDIR}/config-top.h.diff | patch -p0 -l || die
}

src_compile() {

	local myconf
	[ "`use readline`" ] && myconf="--with-installed-readline"
	[ -z "`use nls`" ] && myconf="${myconf} --disable-nls"
	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		--disable-profiling \
		--with-curses \
		--without-gnu-malloc \
		${myconf} || die
	#doesn't like -j
	make || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	dodir /bin
	mv ${D}/usr/bin/bash ${D}/bin
	dosym bash /bin/sh

	if [ -z "`use build`" ]
	then
		doman doc/*.1
		if [ -z "`use readline`" ]
		then
			doman doc/*.3
		fi
		dodoc README NEWS AUTHORS CHANGES COMPAT COPYING Y2K
		dodoc doc/FAQ doc/INTRO
	else
		rm -rf ${D}/usr
	fi
}
