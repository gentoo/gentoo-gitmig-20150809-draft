# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ckermit/ckermit-8.0.ebuild,v 1.9 2004/04/06 04:10:01 vapier Exp $

inherit eutils

MY_P=cku201
DESCRIPTION="combined serial and network communication software package offering a consistent, medium-independent, cross-platform approach to connection establishment, terminal sessions, file transfer, character-set translation, numeric and alphanumeric paging, and automation of communication tasks."
HOMEPAGE="http://www.kermit-project.org/"
SRC_URI="ftp://kermit.columbia.edu/kermit/archives/${MY_P}.tar.gz"

LICENSE="Kermit"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2
	net-dialup/xc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	sed -i -e "s:-O:$CFLAGS:" makefile
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
