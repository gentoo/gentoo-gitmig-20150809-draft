# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xephem/xephem-3.5.2.ebuild,v 1.3 2002/07/25 16:18:19 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XEphem is the X Windows Ephemeris, and provides a scientific-grade solar system model, star charts, sky views, plus a whole lot more."
SRC_URI=""
HOMEPAGE="http://www.clearskyinstitute.com/xephem"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"
DEPEND="x11-libs/openmotif"

pkg_setup() {
	if [ ! -f ${DISTDIR}/${P}.tar.gz ] ; then
		die "Please download ${P}.tar.gz from ${HOMEPAGE} and move it to ${DISTDIR}"
	fi
}

src_unpack() {
	unpack ${P}.tar.gz
}

src_compile() {

	cd libastro
	emake || die
	cd ../libip
	emake || die
	cd ../GUI/xephem
	xmkmf
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

	dodoc Copyright README

}
