# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda/geda-20060123.ebuild,v 1.2 2006/09/05 06:27:08 wormo Exp $

inherit eutils

S=${WORKDIR}

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="geda is a core metapackage which compiles all the necessary components you would need for a minimal gEDA/gaf system"
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
KEYWORDS="~amd64 ppc ~sparc ~x86"
SLOT="0"

DEPEND=">=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-2.2

	>=dev-util/guile-1.6.3
	>=sys-libs/zlib-1.1.0
	>=media-libs/libpng-1.2.0
	>=dev-util/pkgconfig-0.15.0
	>=sci-libs/libgdgeda-2.0.15
	>=sci-libs/libgeda-${PV}"

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
	sed -i -e 's:prefix?=$(HOME)/geda:prefix=/usr:' Makefile || die 'Failed to patch Makefile!'
	sed -i -e 's:^opts=$:opts=--infodir=/usr/share/info --mandir=/usr/share/man:' Makefile || die 'Failed to patch Makefile!'
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
