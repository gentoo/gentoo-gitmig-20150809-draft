# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.0.9-r3.ebuild,v 1.1 2004/02/04 15:32:45 usata Exp $

IUSE="maildir ncurses static doc cjk"

DESCRIPTION="UNIX Shell similar to the Korn shell"
HOMEPAGE="http://www.zsh.org/"

MYDATE="20040204"

SRC_URI="ftp://ftp.zsh.org/pub/${P}.tar.bz2
	doc? ( ftp://ftp.zsh.org/pub/${P}-doc.tar.bz2 )
	cjk? ( http://www.ono.org/software/dist/${P}-euc-0.2.patch.gz )"

SLOT="0"
LICENSE="ZSH"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="virtual/glibc
	sys-apps/groff
	${RDEPEND}"
RDEPEND="ncurses? ( >=sys-libs/ncurses-5.1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use cjk && epatch ../${P}-euc-0.2.patch
	epatch ${FILESDIR}/${PN}-strncmp.diff
	cd ${S}/Doc
	ln -sf . man1
	# fix zshall problem with soelim
	soelim zshall.1 > zshall.1.soelim
	mv zshall.1.soelim zshall.1
}

src_compile() {
	local myconf

	use ncurses && myconf="--with-curses-terminfo"
	use maildir && myconf="${myconf} --enable-maildir-support"
	use static && myconf="${myconf} --disable-dynamic" \
		&& LDFLAGS="${LDFLAGS} -static"

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
		--enable-ldflags="${LDFLAGS}" \
		${myconf} || die "configure failed"
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

	keepdir /usr/share/zsh/site-functions
	insinto /usr/share/zsh/site-functions
	newins ${FILESDIR}/_portage-${MYDATE} _portage

	dodoc ChangeLog* META-FAQ README INSTALL LICENCE config.modules

	if [ "`use doc`" ] ; then
		dohtml Doc/*
		insinto /usr/share/doc/${PF}
		doins Doc/zsh{.dvi,_us.ps,_a4.ps}
	fi

	docinto StartupFiles
	dodoc StartupFiles/z*
}

pkg_preinst() {
	# Our zprofile file does the job of the old zshenv file
	# Move the old version into a zprofile script so the normal
	# etc-update process will handle any changes.
	if [ -f /etc/zsh/zshenv -a ! -f /etc/zsh/zprofile ]; then
		mv /etc/zsh/zshenv /etc/zsh/zprofile
	fi
}
