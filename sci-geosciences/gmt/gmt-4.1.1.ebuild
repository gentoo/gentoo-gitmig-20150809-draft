# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gmt/gmt-4.1.1.ebuild,v 1.3 2010/06/24 19:48:35 jlec Exp $

inherit multilib

MAINV="${PV:0:1}"

DESCRIPTION="Powerful map generator"
HOMEPAGE="http://gmt.soest.hawaii.edu/"
SRC_URI="mirror://gmt/${MAINV}/GMT${PV}_progs.tar.bz2
	mirror://gmt/${MAINV}/GMT_share.tar.bz2
	mirror://gmt/${MAINV}/GMT${PV}_tut.tar.bz2
	mirror://gmt/${MAINV}/GMT${PV}_scripts.tar.bz2
	mirror://gmt/${MAINV}/GMT${PV}_man.tar.bz2
	doc? ( mirror://gmt/${MAINV}/GMT${PV}_pdf.tar.bz2 )
	gmtsuppl? ( mirror://gmt/${MAINV}/GMT${PV}_suppl.tar.bz2 )
	gmtfull? ( mirror://gmt/${MAINV}/GMT_full.tar.bz2 )
	gmthigh? ( mirror://gmt/${MAINV}/GMT_high.tar.bz2 )
	gmttria? ( mirror://gmt/${MAINV}/triangle.tar.bz2 )"
# Needed because GMT_share in version 3 is different of that one in version 4, but they have same name.

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gmtsuppl gmtfull gmthigh gmttria doc"

RDEPEND="
	!sci-biology/probcons
	>=sci-libs/netcdf-3.5.0"
DEPEND="${RDEPEND}
	gmtsuppl? ( >=sys-devel/autoconf-2.58 )"

S="${WORKDIR}/GMT${PV}"

src_unpack() {
	use gmtfull && einfo "Please be patient, this will take some time to unpack..."
	unpack ${A} || die "Unpacking failed."

	mv -f ${WORKDIR}/share/*  ${S}/share/ || die "Moving sources failed."
	if use gmttria; then
		mv -f ${WORKDIR}/src/*  ${S}/src/ || die "Moving gmttria failed."
	fi
}

src_compile() {
	use gmtsuppl && WANT_AUTOCONF=2.5 autoconf # the configure in 3.4.4 is faulty when using gmtsuppl
	# In make process will include /lib and /include to NETCDFHOME
	export NETCDFHOME="/usr"

	local myconf=
	use gmttria && myconf="${myconf} --enable-triangle"
	econf \
		--libdir=/usr/$(get_libdir)/${P} \
		--includedir=/usr/include/${P} \
		--datadir=${D}/usr/share/${P} \
		 ${myconf} \
		|| die "Configure failed."

	local mymake=
	use gmtsuppl && mymake="${mymake} suppl"
	make gmt ${mymake} || die "Make ${mymake} failed."
}

src_install() {
	local mymake=
	use gmtsuppl && mymake="${mymake} install-suppl"
	mkdir -p www/gmt/doc/html
	use doc && mymake="${mymake} install-www"

	einstall \
		includedir=${D}/usr/include/${P} \
		libdir=${D}/usr/$(get_libdir)/${P} \
		datadir=${D}/usr/share/${P} \
		install \
		install-data \
		install-man \
		${mymake} \
		|| die "Make install failed."

	#now some docs
	dodoc CHANGES README
	cp -r ${S}/{examples,tutorial} ${D}/usr/share/doc/${PF}/
	use doc && dodoc ${WORKDIR}/*pdf*

	# Move the HTML and PDF docs to the docs directory. Old location breaks FHS
	# compliance, and is not used by web servers generally.
	if use doc; then
		mv ${D}/usr/www/gmt/doc/pdf/*.pdf ${D}/usr/share/doc/${PF}/
		mv ${D}/usr/www/gmt/doc/html ${D}/usr/share/doc/${PF}/
		rm -rf ${D}/usr/www
	fi

	dodir /etc/env.d
	echo "GMTHOME=/usr/share/${P}" > ${D}/etc/env.d/99gmt
	cd ${D}/usr/share/${P}
	ln -s . share
}

pkg_postinst() {
	einfo "The default installation is the cleanest one"
	einfo "To include more resources use the syntax:"
	einfo "USE=\"gmt_flags\" emerge gmt"
	einfo "Possible GMT flags are:"
	einfo "gmthigh -> High resolution bathimetry database;"
	einfo "gmtfull -> Full resolution bathimetry database;"
	einfo "gmttria -> Non GNU triangulate method, but more efficient;"
	einfo "gmtsuppl -> Supplementary functions for GMT;"
}
