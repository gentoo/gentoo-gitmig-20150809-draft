# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ckermit/ckermit-8.0.209.ebuild,v 1.6 2005/01/01 14:56:21 eradicator Exp $

inherit eutils

MY_P=cku209
S=${WORKDIR}
DESCRIPTION="C-Kermit is a combined serial and network communication software package offering a consistent, medium-independent, cross-platform approach to connection establishment, terminal sessions, file transfer, character-set translation, numeric and alphanumeric paging, and automation of communication tasks."
SRC_URI="ftp://kermit.columbia.edu/kermit/archives/${MY_P}.tar.gz"
HOMEPAGE="http://www.kermit-project.org/"

SLOT="0"
LICENSE="Kermit"
IUSE=""
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2
	net-dialup/xc"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	cp makefile makefile.orig
	sed -e "s:-O:$CFLAGS:" makefile.orig > makefile
}

src_compile() {

	make KFLAGS="-DCK_SHADOW" linux || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/share/doc/${P}

	make \
		DESTDIR=${D} \
		BINDIR=/usr/bin \
		MANDIR=${D}/usr/share/man/man1 \
		INFODIR=/usr/share/doc/${P} \
		MANEXT=1 \
		install || die

	# make the correct symlink
	rm -f ${D}/usr/bin/kermit-sshsub
	dosym /usr/bin/kermit /usr/bin/kermit-sshsub

	#the ckermit.ini script is calling the wrong kermit binary -- the one
	# from ${D}
	dosed /usr/bin/ckermit.ini
}
