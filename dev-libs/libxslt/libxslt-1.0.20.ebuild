# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.0.20.ebuild,v 1.11 2003/09/06 22:29:24 msterret Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="XSLT libraries and tools"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/1.0/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc ppc alpha"

RDEPEND=">=dev-libs/libxml2-2.4.24"

DEPEND="${RDEPEND}
	dev-lang/perl"

src_compile() {
	# Fix .la files of python site packages
	elibtoolize

	econf || die
	#libxslt-1.0.19 didn't like parallel make; test a good deal before re-enabling
	#(drobbins, 24 Jul 2002)
	patch -p0 < ${FILESDIR}/Makefile-py.patch
	make || die
}

src_install() {
	make DESTDIR=${D} \
		DOCS_DIR=/usr/share/doc/${PF}/python \
		EXAMPLE_DIR=/usr/share/doc/${PF}/python/example \
		BASE_DIR=/usr/share/doc \
		DOC_MODULE=${PF} \
		EXAMPLES_DIR=/usr/share/doc/${PF}/example \
		TARGET_DIR=/usr/share/doc/${PF}/html \
		install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
}
