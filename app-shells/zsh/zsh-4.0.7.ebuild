# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.0.7.ebuild,v 1.1 2003/07/23 17:48:19 usata Exp $

IUSE="maildir ncurses"

DESCRIPTION="UNIX Shell similar to the Korn shell"
HOMEPAGE="http://www.zsh.org/"

MYPATCH="${P/-/_}-5.diff"
# New zshall.1 generated with the following, run in Doc:
# perl -nle'$_ = `cat $1` if /^\.so man1\/(.+\.1)/;print' zshall.1
ZSHALL="${P}-zshall-gentoo.diff"
SRC_URI="ftp://ftp.zsh.org/pub/${P}.tar.gz
	 http://ftp.debian.org/debian/pool/main/z/${PN}/${MYPATCH}.gz
	 http://dev.gentoo.org/~usata/distfiles/${ZSHALL}.bz2"

SLOT="0"
LICENSE="ZSH"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.1 )"

src_unpack() {
	unpack ${A}
	epatch ${MYPATCH}
	epatch ${ZSHALL}
}
	
src_compile() {
	local myconf

	use ncurses && myconf="--with-curses-terminfo"
	use maildir && myconf="${myconf} --enable-maildir-support"

	econf \
		--bindir=/bin \
		--libdir=/usr/lib \
		--enable-etcdir=/etc/zsh \
		--enable-zshenv=/etc/zsh/zshenv \
		--enable-zlogin=/etc/zsh/zlogin \
		--enable-zlogout=/etc/zsh/zlogout \
		--enable-zprofile=/etc/zsh/zprofile \
		--enable-zshrc=/etc/zsh/zshrc \
		--enable-fndir=/usr/share/zsh/${PV}/functions \
		--enable-site-fndir=/usr/share/zsh/site-functions \
		--enable-function-subdirs \
		${myconf}
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

	insinto /etc/zsh
	doins ${FILESDIR}/zprofile

	dodoc ChangeLog* META-FAQ README INSTALL LICENCE config.modules

	docinto StartupFiles
 	dodoc StartupFiles/z*
}
