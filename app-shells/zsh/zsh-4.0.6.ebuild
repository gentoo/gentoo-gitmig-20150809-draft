# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.0.6.ebuild,v 1.2 2002/08/19 12:55:28 phoenix Exp $

DESCRIPTION="UNIX Shell similar to the Korn shell"
SRC_URI="ftp://ftp.zsh.org/pub/${P}.tar.gz"
HOMEPAGE="www.zsh.org/"
SLOT="0"
LICENSE="ZSH"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1"

RDEPEND="${DEPEND}"

KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} \
		--bindir=/bin \
		--mandir=/usr/share/man \
		--libdir=/usr/lib \
		--infodir=/usr/share/info \
		--enable-maildir-support \
		--enable-etcdir=/etc/zsh \
		--enable-zshenv=/etc/zsh/zshenv \
		--enable-zshlogin=/etc/zsh/zshlogin \
		--enable-zshrc=/etc/zsh/zshrc \
		--enable-fndir=/usr/share/zsh \
		--enable-function-subdirs || die "configure failed"
	# emake still b0rks
	make || die "make failed"
	make check || die "make check failed"
}

src_install() {
	make prefix=${D}/usr \
		bindir=${D}/bin \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib \
		fndir=${D}/usr/share/zsh \
		infodir=${D}/usr/share/info \
		install.bin install.man install.modules \
		install.info install.fns || die "make install failed"
		
	dodoc ChangeLog META-FAQ README INSTALL LICENCE config.modules
	docinto StartupFiles
 	dodoc StartupFiles/z*
	dodir /etc/zsh
	cp ${S}/StartupFiles/z* ${D}/etc/zsh

	rm -rf ${D}/share
}
