# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gmt/gmt-3.4.4.ebuild,v 1.1 2004/03/24 07:05:11 phosphan Exp $

MAINV="${PV:0:1}"

DESCRIPTION="Powerfull map generator"
HOMEPAGE="http://gmt.soest.hawaii.edu/"
SRC_URI="ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT${PV}_progs.tar.bz2
	ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT_share.tar.bz2
	ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT${PV}_tut.tar.bz2
	ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT${PV}_scripts.tar.bz2
	ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT${PV}_man.tar.bz2
	gmtsuppl? ( ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT${PV}_suppl.tar.bz2)
	gmtfull? ( ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT_full.tar.bz2 )
	gmthigh? ( ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/GMT_high.tar.bz2 )
	gmttria? ( ftp://gmt.soest.hawaii.edu/pub/gmt/${MAINV}/triangle.tar.bz2 )"
	#gmtpdf? ( ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_pdf.tar.bz2 )

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gmtsuppl gmtfull gmthigh gmttria"

#Need to include gcc and bzip??
DEPEND=">=app-sci/netcdf-3.5.0"
#RDEPEND=""

S="${WORKDIR}/GMT${PV}"

pkg_setup() {
	einfo "The default instalation is the cleanest one. To include more "
	einfo "resources take a look at ebuild file."
}

src_unpack() {

	unpack ${A} || die

	mv -f ${WORKDIR}/share/*  ${S}/share/ || die
	if [ `use gmttria` ] ; then
		mv -f ${WORKDIR}/src/*  ${S}/src/ || die
	fi
}

src_compile() {
	#In make process will include /lib and /include to NETCDFHOME
	export NETCDFHOME="/usr"

	local myconf=
	use gmttria && myconf="${myconf} --enable-triangle"
	econf \
		--libdir=/usr/lib/gmt-${PV}·\
		--includedir=/usr/include/gmt-${PV}·\
		 ${myconf} \
		|| die "configure failed"

	local mymake=
	use gmtsuppl && mymake="${mymake} suppl"
	make gmt ${mymake} || die "make ${mymake} failed"
}

src_install() {
	local mymake=
	use gmtsuppl && mymake="${mymake} install-suppl"
	use doc && mymake="${mymake} install-www"

	einstall \
		includedir=${D}/usr/include/gmt-${PV} \
		libdir=${D}/usr/lib/gmt-${PV}·\
		install \
		install-data \
		install-man \
		${mymake} \
		|| die "install failed"

	#now some docs
	dodoc CHANGES COPYING README
	cp -r ${S}/{examples,tutorial} ${D}/usr/share/doc/${PF}/
}

pkg_postinst() {
	einfo "The default instalation is the cleanest one"
	einfo "To include more resources use the syntax:"
	einfo "env USE=\"\${USE} gmt_flags\" emerge gmt"
	einfo "Possible GMT flags are:"
	#einfo "gmtman -> man documents;"
	#einfo "gmtpdf -> PDF documents;"#Not right setted yet
	einfo "gmthigh -> High resolution bathimetry data base;"
	einfo "gmtfull -> Full resolution bathimetry data base;"
	einfo "gmttria -> Non GNU triangulate method, but more efficient;"
	einfo "gmtsuppl -> Supplement functions for GMT;"
	einfo "Others GMT flags will be included soon."
}
