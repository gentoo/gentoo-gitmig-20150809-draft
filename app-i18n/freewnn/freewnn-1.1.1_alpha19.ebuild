# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/freewnn/freewnn-1.1.1_alpha19.ebuild,v 1.6 2003/09/06 22:19:21 msterret Exp $

KEYWORDS="x86 sparc"

DESCRIPTION="Network-Extensible Kana-to-Kanji Conversion System"
HOMEPAGE="http://www.freewnn.org/"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

SLOT=0

A="FreeWnn-1.1.1-a019.tar.gz"

SRC_URI="ftp://ftp.freewnn.org/pub/FreeWnn/alpha/${A}
	ftp://ftp.st.ryukoku.ac.jp/pub/japanese-im/FreeWnn/alpha/${A}
	ftp://ftp.kddlabs.co.jp/Japan/Wnn/FreeWnn/alpha/${A}
	ftp://ftp.tomo.gr.jp/pub/FreeWnn/alpha/${A}
	ftp://etlport.etl.go.jp/pub/FreeWnn/alpha/${A}"

S=${WORKDIR}/FreeWnn-1.1.1-a019

src_unpack() {
	unpack $A
	#Change WNNOWNER to root so we don't need to add wnn user
	mv ${S}/makerule.mk.in ${S}/makerule.mk.in.orig
	sed -e "s/WNNOWNER = wnn/WNNOWNER = root/" ${S}/makerule.mk.in.orig > ${S}/makerule.mk.in
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
                --disable-cWnn \
                --disable-kWnn \
                --without-termcap \
                --with-x \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
	#make || die
}

src_install () {
	# install executables, libs ,dictionaries
	make DESTDIR=${D} install || die "installation failed"
	# install man pages
	make DESTDIR=${D} install.man || die "installation of manpages failed"
	# install docs
	dodoc ChangeLog ChangeLog.en INSTALL INSTALL.en CONTRIBUTORS
	# install rc script
	exeinto /etc/init.d ; newexe ${FILESDIR}/freewnn.initd freewnn
}
