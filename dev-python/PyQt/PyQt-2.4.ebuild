# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: tools@cvs.gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-2.4.ebuild,v 1.4 2001/11/10 12:14:29 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PyQt is a set of Python bindings for the Qt Toolkit."
SRC_URI="http://www.river-bank.demon.co.uk/software/${P}.tar.gz"
HOMEPAGE="http://www.thekompany.com/projects/pykde/"

DEPEND=">=x11-libs/qt-x11-1.4.2
        =dev-python/sip-2.4
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
