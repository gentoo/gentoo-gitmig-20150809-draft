# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda/geda-20050313.ebuild,v 1.1 2005/03/26 00:37:03 plasmaroo Exp $

inherit eutils

S=${WORKDIR}

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="geda is a metapackage which compiles all the necessary components you would need for a gEDA/gaf system"
SRC_URI="http://www.geda.seul.org/devel/${PV}/geda-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-docs-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-examples-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-gattrib-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-gnetlist-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-gschem-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-gsymcheck-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-symbols-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-utils-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/libgeda-${PV}.tar.gz
	 http://dev.gentoo.org/~plasmaroo/patches/geda/${P}.Makefile"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND=">=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-2.2
	 =x11-libs/gtk+-1.2*
	virtual/x11

	>=dev-util/pkgconfig-0.15.0
	>=sci-libs/libgdgeda-2.0.15

	>=sci-libs/libgeda-${PV}
	>=sci-electronics/gerbv-1.00
	>=sci-electronics/gnucap-0.33
	>=sci-electronics/gtkwave-2.0.0_pre20030319
	>=sci-electronics/gwave-20031224
	>=sci-electronics/pcb-20040903
	>=sci-electronics/iverilog-0.8
	>=sci-electronics/tclspice-0.2.15
	>=sci-electronics/vbs-1.4.0
	>=sci-electronics/ng-spice-rework-15
	>=sci-electronics/gnetman-0.0.1_pre20041222"

src_unpack() {
	unpack geda-${PV}.tar.gz
	unpack geda-docs-${PV}.tar.gz
	unpack geda-examples-${PV}.tar.gz
	unpack geda-gattrib-${PV}.tar.gz
	unpack geda-gnetlist-${PV}.tar.gz
	unpack geda-gschem-${PV}.tar.gz
	unpack geda-gsymcheck-${PV}.tar.gz
	unpack geda-symbols-${PV}.tar.gz
	unpack geda-utils-${PV}.tar.gz
	unpack libgeda-${PV}.tar.gz
	for file in $(find geda-gnetlist-${PV} -name "*.scm"); do
		sed -e 's:/usr/X11R6/lib/X11/pcb/m4:/usr/share/pcb/m4:g' \
			-i ${file}
	done
	cp ${DISTDIR}/${P}.Makefile Makefile
	sed -i -e 's:prefix=$(HOME)/geda:prefix=/usr:' Makefile || die 'Failed to patch Makefile!'
}

src_install () {
	make DESTDIR=${D} install || die

	cd libgeda-${PV}
	make DESTDIR=${D} uninstall || sh
	rm ${D}/usr/include -Rf
	rm ${D}/usr/share/gEDA/sym/gnetman -Rf # Fix collision with gnetman; bug #77361.

	cd ${S}
	dodoc geda-${PV}/AUTHORS geda-${PV}/README

	dodoc geda-gattrib-${PV}/{AUTHORS,README}
	dodoc geda-examples-${PV}/README
	dodoc geda-gnetlist-${PV}/AUTHORS geda-gnetlist-${PV}/BUGS
	dodoc geda-gschem-${PV}/AUTHORS geda-gschem-${PV}/BUGS
	dodoc geda-gsymcheck-${PV}/AUTHORS
	dodoc geda-symbols-${PV}/AUTHORS
	dodoc geda-utils-${PV}/AUTHORS geda-utils-${PV}/README*
}
