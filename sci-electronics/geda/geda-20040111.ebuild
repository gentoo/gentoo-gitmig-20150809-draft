# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda/geda-20040111.ebuild,v 1.6 2004/12/27 19:53:00 ribosome Exp $

S=${WORKDIR}

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="geda is a metapackage which compiles all the necessary components you would need for a gEDA/gaf system"
SRC_URI="http://www.geda.seul.org/devel/${PV}/geda-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-docs-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-examples-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-gnetlist-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-gschem-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-gsymcheck-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-setup-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-symbols-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/geda-utils-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/libgeda-${PV}.tar.gz
	 http://www.geda.seul.org/devel/${PV}/Makefile"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-2.2
	 =x11-libs/gtk+-1.2*
	virtual/x11

	>=dev-util/pkgconfig-0.15.0
	>=app-sci/libgdgeda-2.0.15

	>=app-sci/libgeda-${PV}
	>=sci-electronics/gerbv-0.15
	>=sci-electronics/gnucap-0.33
	>=sci-electronics/gtkwave-2.0.0_pre20030319
	>=sci-electronics/gwave-20031224
	>=sci-electronics/iverilog-0.7
	>=app-sci/tclspice-0.2.15
	>=app-sci/vbs-1.4.0
	>=app-sci/ng-spice-rework-15"

src_unpack() {

	unpack geda-${PV}.tar.gz
	unpack geda-docs-${PV}.tar.gz
	unpack geda-examples-${PV}.tar.gz
	unpack geda-gnetlist-${PV}.tar.gz
	unpack geda-gschem-${PV}.tar.gz
	unpack geda-gsymcheck-${PV}.tar.gz
	unpack geda-setup-${PV}.tar.gz
	unpack geda-symbols-${PV}.tar.gz
	unpack geda-utils-${PV}.tar.gz
	unpack libgeda-${PV}.tar.gz

	cp ${DISTDIR}/Makefile ${S}
	sed -i -e 's:prefix=${HOME}/geda:prefix=/usr:' ${S}/Makefile

}

src_install () {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} libgeda_uninstall || die
	rm ${D}/usr/include -Rf

	dodoc geda-${PV}/AUTHORS geda-${PV}/README
	dodoc geda-examples-${PV}/README
	dodoc geda-gnetlist-${PV}/AUTHORS geda-gnetlist-${PV}/BUGS
	dodoc geda-gschem-${PV}/AUTHORS geda-gschem-${PV}/BUGS
	dodoc geda-gsymcheck-${PV}/AUTHORS
	dodoc geda-symbols-${PV}/AUTHORS
	dodoc geda-utils-${PV}/AUTHORS geda-utils-${PV}/README*

}
