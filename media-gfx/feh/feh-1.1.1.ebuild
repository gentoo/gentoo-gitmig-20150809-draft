# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.1.1.ebuild,v 1.1 2002/02/25 20:29:16 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A fast, lightweight imageviewer using imlib2"
SRC_URI="http://www.linuxbrit.co.uk/downloads/feh-${PV}.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/feh"

DEPEND="media-libs/imlib2"


src_compile() {

	./configure --prefix=/usr		\
		--mandir=/usr/share/man		\
		--infodir=/usr/share/info	\
		--host=${CHOST} || die
    
	emake || die
}

src_install () {

	make prefix=${D}/usr					\
		mandir=${D}/usr/share/man			\
		infodir=${D}/usr/share/info			\
		docsdir=${D}/usr/share/doc/${PF}	\
		install || die

	# gzip the docs
	gzip ${D}/usr/share/doc/${PF}/*
}

