# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xephem/xephem-3.5.2.ebuild,v 1.5 2002/09/02 02:08:05 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XEphem is the X Windows Ephemeris, and provides a scientific-grade solar system model, star charts, sky views, plus a whole lot more."
SRC_URI="xephem-${PV}.tar.gz"
HOMEPAGE="http://www.clearskyinstitute.com/xephem"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"
DEPEND="x11-libs/openmotif"

if [ ! -f ${DISTDIR}/${P}.tar.gz ] ; then
	die "Please download ${P}.tar.gz from ${HOMEPAGE} and move it to ${DISTDIR}"
fi

src_compile() {

	cd libastro
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS=.*:CFLAGS=${CFLAGS} -ffast-math -Wall:" \
			Makefile.orig > Makefile
	emake || die
	cd ../libip
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS=*:CFLAGS=${CFLAGS} -I../libastro -ffast-math -Wall:" \
			Makefile.orig > Makefile
	emake || die
	cd ../GUI/xephem
	xmkmf
	mv Makefile Makefile.orig
	sed -e "s:CDEBUGFLAGS = .*:CDEBUGFLAGS = ${CFLAGS} -fno-strength-reduce:" \
			Makefile.orig > Makefile
	emake || die
	
}

src_install() {

	into /usr
	dobin ${S}/GUI/xephem/xephem
	insinto /opt/xephem/auxil
	doins ${S}/GUI/xephem/auxil/*
	insinto /opt/xephem/catalogs
	doins ${S}/GUI/xephem/catalogs/*
	insinto /opt/xephem/fifos
	doins ${S}/GUI/xephem/fifos/*
	insinto /opt/xephem/fits
	doins ${S}/GUI/xephem/fits/*

	cat > ${S}/XEphem <<EOT
XEphem.ShareDir: /opt/xephem
EOT
	insinto /usr/lib/X11/app-defaults/
	doins ${S}/XEphem
	
	dodoc Copyright README INSTALL
	mv ${S}/GUI/xephem/xephem.man ${S}/xephem.1
	doman ${S}/xephem.1
}
