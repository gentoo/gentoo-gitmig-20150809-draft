# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.0.ebuild,v 1.4 2002/02/17 18:56:03 karltk Exp $

S="${WORKDIR}/PyQt-3.0"
DESCRIPTION="PyQt is a set of Python bindings for the Qt Toolkit( VERSION 3.x ONLY!!."
SRC_URI="http://www.river-bank.demon.co.uk/software/PyQt-3.0-Qt-3.0.0.tar.gz
	 http://www.river-bank.demon.co.uk/software/PyQt-3.0-Qt-3.0.0-patch.1
	 http://www.river-bank.demon.co.uk/software/PyQt-3.0-Qt-3.0.0-patch.2
	 http://www.river-bank.demon.co.uk/software/PyQt-3.0-Qt-3.0.0-patch.3
	 http://www.river-bank.demon.co.uk/software/PyQt-3.0-Qt-3.0.0-patch.4
	"
HOMEPAGE="http://www.thekompany.com/projects/pykde/"

DEPEND="virtual/glibc
	=x11-libs/qt-3*
        =dev-python/sip-3.0
        >=dev-lang/python-2.0"

src_unpack() {

	unpack PyQt-3.0-Qt-3.0.0.tar.gz
	cd ${WORKDIR}
	patch -p0 < ${DISTDIR}/PyQt-3.0-Qt-3.0.0-patch.1 || die 
	patch -p0 < ${DISTDIR}/PyQt-3.0-Qt-3.0.0-patch.2 || die
	patch -p0 < ${DISTDIR}/PyQt-3.0-Qt-3.0.0-patch.3 || die
	patch -p0 < ${DISTDIR}/PyQt-3.0-Qt-3.0.0-patch.4 || die
	cd ${S}
	
}

src_compile() {
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-doc-install=/usr/share/doc \
		--with-qt-dir=/usr/qt/3 \
		--with-qt-includes=/usr/qt/3/include \
		--with-qt-libraries=/usr/qt/3/lib \
		--with-x || die
		
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install-doc || die
}
