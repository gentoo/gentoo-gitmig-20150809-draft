# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.1.ebuild,v 1.1 2002/04/02 13:23:51 verwilst Exp $


S="${WORKDIR}/PyQt-3.1"
DESCRIPTION="PyQt is a set of Python bindings for the Qt Toolkit( VERSION 3.x ONLY!!)."
SRC_URI="http://www.riverbankcomputing.co.uk/download/PyQt/PyQt-3.1-Qt-3.0.2.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SLOT="0"

DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.2
        >=dev-lang/python-2.2
        =dev-python/sip-3.1"

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

