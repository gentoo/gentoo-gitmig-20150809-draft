# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# This ebuild by Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.0.4-r2.ebuild,v 1.5 2002/07/25 15:39:00 aliz Exp $


S=${WORKDIR}/${P}
DESCRIPTION="UNIX Shell similar to the Korn shell"
SRC_URI="ftp://ftp.zsh.org/pub/${P}.tar.gz"
HOMEPAGE="www.zsh.org/"
SLOT="0"
LICENSE="ZSH"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1"

KEYWORDS="x86 ppc"

src_compile() {
	./configure --prefix=/ --host=${CHOST} \
		--mandir=/usr/share/man \
		--libdir=/usr/lib \
		--infodir=/usr/share/info \
		--enable-maildir-support \
		--enable-etcdir=/etc/zsh \
		--enable-zshenv=/etc/zsh/zshenv \
		--enable-zshlogin=/etc/zsh/zshlogin \
		--enable-zshrc=/etc/zsh/zshrc \
		--enable-fndir=/usr/share \
		--enable-function-subdirs || die
	# Can't use emake, b0rks
	make || die
	# make check violates sandboxing
#	make check || die
}

src_install() {
	make prefix=${D} \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib \
		fndir=${D}/usr/share \
		infodir=${D}/usr/share/info \
		install.bin install.man install.modules \
		install.info install.fns || die
		
	dodoc ChangeLog META-FAQ README INSTALL LICENCE config.modules
	docinto StartupFiles
 	dodoc StartupFiles/z*
	dodir /etc/zsh
	cp ${S}/StartupFiles/z* ${D}/etc/zsh

	rm -rf ${D}/share
}
