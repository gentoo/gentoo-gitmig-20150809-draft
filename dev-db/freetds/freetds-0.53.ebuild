#Copyright 2002 Gentoo Technologies, Inc.
#Distributed under the terms of the GNU General Public License, v2 or later
#Author <root@station-1.internal.feedbackplusinc.com>

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Tabular Datastream Library"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/${P}.tgz"
HOMEPAGE="http://ibiblio.org/pub/Linux/ALPHA/freetds/"
DEPEND="virtual/glibc"
RDEPEND=${DEPEND}

src_unpack() {

	unpack ${P}.tgz
	cd ${S}

}

src_compile() {

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-tdsver=7.0 \
		|| die "./configure failed"

	emake || die

	 mv ${S}/Makefile ${S}/Makefile.orig
	 sed -e 's/^DEFDIR = /DEFDIR = $(DESTDIR)/' \
		 -e 's/^ETC = /ETC = $(DESTDIR)/' \
		 ${S}/Makefile.orig > ${S}/Makefile
}

src_install () {

	make DESTDIR=${D} install || die
}



