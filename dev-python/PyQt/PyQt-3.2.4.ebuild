# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.2.4.ebuild,v 1.2 2002/07/19 05:22:10 chadh Exp $


S="${WORKDIR}/PyQt-3.2.4"
DESCRIPTION="PyQt is a set of Python bindings for the Qt Toolkit( VERSION 3.x ONLY!!)."
SRC_URI="http://www.riverbankcomputing.co.uk/download/PyQt/PyQt-3.2.4-Qt-3.0.4-X11.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
LICENSE="" # just says "based on MIT/X license ???
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.4.1
    	>=dev-lang/python-2.2
    	=dev-python/sip-3.2.4"
RDEPEND="${DEPEND}"

src_compile() {

	# Fix for one installation problem. The libtool included with the
	# source package does not have the relink patch.
	# Use the system libtool instead.
	cd ${S}
	cp /usr/bin/libtool .
	cp /usr/share/libtool/ltmain.sh .
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-doc-install=/usr/share/doc/${PF} \
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


