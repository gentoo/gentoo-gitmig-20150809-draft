# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xephem/xephem-3.6.1.ebuild,v 1.1 2004/09/19 06:02:13 morfic Exp $

DESCRIPTION="XEphem is the X Windows Ephemeris, and provides a scientific-grade solar system model, star charts, sky views, plus a whole lot more."
SRC_URI="${PN}-${PV}.tar.gz"
HOMEPAGE="http://www.clearskyinstitute.com/xephem"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
SLOT="0"
LICENSE="as-is"
DEPEND="x11-libs/openmotif"
RESTRICT="fetch"

pkg_setup() {
	if [ ! -f ${DISTDIR}/${P}.tar.gz ] ; then
		die "Please download ${P}.tar.gz from ${HOMEPAGE} and move it to ${DISTDIR}"
	fi
}

src_compile() {

	cd libastro
	sed -e "s:CFLAGS=.*:CFLAGS=${CFLAGS} -ffast-math -Wall:" \
			-i Makefile
	emake || die

	for i in libip liblilxml libjpegd; do
		echo "going into ${i}"
		cd ${S}/${i}
		sed -e "s:CFLAGS=.*:CFLAGS=${CFLAGS} -I../libastro -ffast-math -Wall:" \
				-i Makefile
		emake || die
	done

	cd ../GUI/xephem
	xmkmf
	sed -e "s:CDEBUGFLAGS = .*:CDEBUGFLAGS = ${CFLAGS} -fno-strength-reduce:" \
			-i Makefile
	emake || die

}

src_install() {

	into /usr
	dobin ${S}/GUI/xephem/xephem
	for i in auxil catalogs fifos fits help help/png; do
		insinto /opt/xephem/${i}
		doins ${S}/GUI/xephem/${i}/*
	done

	cat > ${S}/XEphem <<EOT
XEphem.ShareDir: /opt/xephem
EOT
	insinto /usr/lib/X11/app-defaults/
	doins ${S}/XEphem

	dodoc Copyright README INSTALL
	mv ${S}/GUI/xephem/xephem.man ${S}/xephem.1
	doman ${S}/xephem.1
}
