# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gmt/gmt-3.4.2.ebuild,v 1.1 2003/02/07 04:40:47 george Exp $

#NOTE: To build a light GMT you could compile without some resources like: HIGH and FULL data base resolution and PDF documentation. For so, use something like export NO_FULL="YES"; export NO_HIGH="YES"; export NO_PDF="YES"; ...

DESCRIPTION="Powerfull map generator"

HOMEPAGE="http://gmt.soest.hawaii.edu/"

SRC_URI="ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_progs.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT_share.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_man.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_tut.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_scripts.tar.bz2"

#Without PDF documentation
if [ "${NO_PDF}" != "YES" ] | [ "${NO_PDF}" != "yes" ]
	then
		SRC_URI="${SRC_URI} ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_pdf.tar.bz2"
fi
#Without FULL data base resolution
if [ "${NO_FULL}" != "YES" ] | [ "${NO_FULL}" != "yes" ]
	then
		SRC_URI="${SRC_URI} ftp://gmt.soest.hawaii.edu/pub/gmt/GMT_full.tar.bz2"
fi
#Without HIGH data base resolution
if [ "${NO_HIGH}" != "YES" ] | [ "${NO_HIGH}" != "yes" ]
	then
		SRC_URI="${SRC_URI} ftp://gmt.soest.hawaii.edu/pub/gmt/GMT_high.tar.bz2"
fi


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

#Need to include gcc and bzip??
DEPEND=">=app-sci/netcdf-3.5.0"

#RDEPEND=""

S="${WORKDIR}/GMT${PV}"

src_unpack() {
	unpack ${A} || die
	mv ${WORKDIR}/share/*  ${S}/share/ || die
}

src_compile() {
	export NETCDFHOME="/usr/lib"
		./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--libdir=/usr/lib/gmt-${PV} \
		--includedir=/usr/include/gmt-${PV} \
		--mandir=/usr/man \
		--datadir=/usr/share/gmt-${PV} \
		|| die "configure failed"

	make all || die
}

src_install() {

	make \
		prefix=${D}/usr \
		bindir=${D}/usr/bin \
		libdir=${D}/usr/lib/gmt-${PV} \
		includedir=${D}/usr/include/gmt-${PV} \
		mandir=${D}/usr/man \
		datadir=${D}/usr/share/gmt-${PV} \
		install install-data install-man \
		|| die "install failed"

}
