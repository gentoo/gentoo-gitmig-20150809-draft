# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.1.0_pre7.ebuild,v 1.1 2003/04/17 08:39:02 vladimir Exp $

IUSE="ncurses"
MY_PV=${PV%_*}-dev-${PV#*_pre}
MY_PN=${PN}-${MY_PV}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="UNIX Shell similar to the Korn shell"
HOMEPAGE="http://www.zsh.org/"
SRC_URI="ftp://ftp.zsh.org/pub/zsh/development/${MY_PN}.tar.bz2
		http://cvs.gentoo.org/~vladimir/distfiles/zshall-${MY_PV}.bz2"

SLOT="0"
LICENSE="ZSH"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.1 )"

src_compile() {

	# New zshall.1 generated with the following, run in Doc:
	# perl -nle'$_ = `cat $1` if /^\.so man1\/(.+\.1)/;print' zshall.1
	mv ${WORKDIR}/zshall-${MY_PV} ${S}/Doc/zshall.1
	
	use ncurses && MYCONF="--with-curses-terminfo"
	
	econf \
		--bindir=/bin \
		--libdir=/usr/lib \
		--with-curses-terminfo \
		--enable-maildir-support \
		--enable-etcdir=/etc/zsh \
		--enable-zshenv=/etc/zsh/zshenv \
		--enable-zshlogin=/etc/zsh/zshlogin \
		--enable-zshrc=/etc/zsh/zshrc \
		--enable-fndir=/usr/share/zsh/${PV}/functions \
		--enable-site-fndir=/usr/share/zsh/site-functions \
		--enable-function-subdirs \
		${MYCONF}
	# emake still b0rks
	make || die "make failed"
	#make check || die "make check failed"
}

src_install() {
	einstall \
		bindir=${D}/bin \
		libdir=${D}/usr/lib \
		fndir=${D}/usr/share/zsh/${PV}/functions \
		sitefndir=${D}/usr/share/zsh/site-functions \
		install.bin install.man install.modules \
		install.info install.fns || die "make install failed"
		
	dodoc ChangeLog META-FAQ README INSTALL LICENCE config.modules
	docinto StartupFiles
 	dodoc StartupFiles/z*

	insinto /etc/zsh
	doins ${FILESDIR}/zshenv
}
