# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gmt/gmt-3.4.3.ebuild,v 1.1 2003/07/09 18:21:34 george Exp $


DESCRIPTION="Powerfull map generator"

HOMEPAGE="http://gmt.soest.hawaii.edu/"

SRC_URI="ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_progs.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT_share.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_tut.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_scripts.tar.bz2
			ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_man.tar.bz2
			gmtsuppl? ( ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_suppl.tar.bz2)
			gmtfull? ( ftp://gmt.soest.hawaii.edu/pub/gmt/GMT_full.tar.bz2 )
			gmthigh? ( ftp://gmt.soest.hawaii.edu/pub/gmt/GMT_high.tar.bz2 )
			gmttria? ( ftp://gmt.soest.hawaii.edu/pub/gmt/triangle.tar.bz2 )"
			#gmtpdf? ( ftp://gmt.soest.hawaii.edu/pub/gmt/GMT${PV}_pdf.tar.bz2 )

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

#Internal USE flags.
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
	if [ -n "`use gmttria`" ]; then
	  mv -f ${WORKDIR}/src/*  ${S}/src/ || die
	fi

}

src_compile() {
    #In make process will include /lib and /include to NETCDFHOME
	export NETCDFHOME="/usr"

	local myconf mymake

	myconf=" --prefix=/usr \
      --bindir=/usr/bin \
      --libdir=/usr/lib/gmt-${PV} \
      --includedir=/usr/include/gmt-${PV} \
      --mandir=/usr/man
	  --datadir=/usr/share/${PN}"

	use gmttria && myconf="${myconf} --enable-triangle"

	./configure ${myconf} \
	  || die "configure failed"

	mymake="gmt"
	use gmtsuppl && mymake="${mymake} suppl"

	make ${mymake} \
	  || die "make ${mymake} failed"

}

src_install() {
	mymake="install install-data install-man"

	use gmtsuppl && mymake="${mymake} install-suppl"
	use doc && mymake="${mymake} install-www"

	make \
		prefix=${D}/usr \
		bindir=${D}/usr/bin \
		libdir=${D}/usr/lib/gmt-${PV} \
		includedir=${D}/usr/include/gmt-${PV} \
		mandir=${D}/usr/man \
		datadir=${D}/usr/share/${PN} \
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
