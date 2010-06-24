# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gmt/gmt-4.5.0-r2.ebuild,v 1.1 2010/06/24 19:48:35 jlec Exp $

inherit multilib autotools eutils

GSHHS="GSHHS2.0"

DESCRIPTION="Powerful map generator"
HOMEPAGE="http://gmt.soest.hawaii.edu/"
SRC_URI="mirror://gmt/GMT${PV}_src.tar.bz2
	mirror://gmt/GMT${PV}_share.tar.bz2
	mirror://gmt/${GSHHS}_coast.tar.bz2
	doc? ( mirror://gmt/GMT${PV}_doc.tar.bz2 )
	gmtsuppl? ( mirror://gmt/GMT${PV}_suppl.tar.bz2 )
	gmtfull? ( mirror://gmt/${GSHHS}_full.tar.bz2 )
	gmthigh? ( mirror://gmt/${GSHHS}_high.tar.bz2 )
	gmttria? ( mirror://gmt/GMT${PV}_triangle.tar.bz2 )"

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
	unpack ${A} || die "Unpacking failed."
	epatch "${FILESDIR}/${P}-no-strip.patch"
	mv -f "${WORKDIR}/share/"*  "${S}/share/" || die "Moving sources failed."
	cd "${S}"
	if use gmtsuppl; then
		WANT_AUTOCONF=2.5 eautoreconf || die "autoconf failed."
	fi
}

src_compile() {

	# In make process will include /lib and /include to NETCDFHOME
	export NETCDFHOME="/usr"

	local myconf=""

	if use gmttria; then
		myconf="${myconf} --enable-triangle"
	fi

	econf \
		--libdir=/usr/$(get_libdir)/${P} \
		--includedir=/usr/include/${P} \
		--datadir=/usr/share/${P} \
		 ${myconf} \
		|| die "Configure failed."

	local mymake=
	if use gmtsuppl; then
		mymake="${mymake} suppl"
	fi

	emake gmt ${mymake} || die "Make ${mymake} failed."
}

src_install() {
	local mymake=
	if use gmtsuppl; then
		mymake="${mymake} install-suppl"
	fi
	if use doc; then
		mymake="${mymake} install-doc"
		mkdir -p www/gmt/doc/html
	fi

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
	dodoc README
	cp -r "${S}/{examples,tutorial}" "${D}/usr/share/doc/${PF}/"

	# Move the HTML and PDF docs to the docs directory. Old location breaks FHS
	# compliance, and is not used by web servers generally.
	if use doc; then
		mv "${D}/usr/www/gmt/doc/pdf/*.pdf" "${D}/usr/share/doc/${PF}/"
		mv "${D}/usr/www/gmt/doc/html" "${D}/usr/share/doc/${PF}/"
		rm -rf "${D}/usr/www"
	fi

#	dodir /etc/env.d
#	echo "GMTHOME=/usr/share/${P}" > ${D}/etc/env.d/99gmt
	cd "${D}/usr/share/${P}"
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
