# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/qt2.3.1_PyQt-3.0.ebuild,v 1.1 2001/11/27 21:55:06 verwilst Exp $

S="${WORKDIR}/PyQt-3.0"
DESCRIPTION="PyQt is a set of Python bindings for the Qt Toolkit."
SRC_URI="http://www.river-bank.demon.co.uk/software/PyQt-3.0-Qt-2.3.1.tar.gz"
HOMEPAGE="http://www.thekompany.com/projects/pykde/"

DEPEND="virtual/glibc
	>=x11-libs/qt-x11-2.3
        =dev-python/sip-3.0
        virtual/python"

src_compile() {
	./configure --prefix=/usr					\
		    --infodir=/usr/share/info				\
		    --mandir=/usr/share/man				\
		    --with-doc-install=/usr/share/doc
	assert

	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install-doc || die
}
