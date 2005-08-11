# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/omni/omni-1.6-r1.ebuild,v 1.1 2005/08/11 23:40:39 robbat2 Exp $

IUSE="java doc"

MY_PN="Omni"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="The Omni OpenMP Compiler"
HOMEPAGE="http://phase.hpcc.jp/Omni/home.html"
SLOT="0"
LICENSE="Omni"
KEYWORDS="~x86"

#RESTRICT="fetch"
# Read the license more carefully! It does permit redistribution.

DEPEND="java? ( virtual/jdk
	app-arch/zip )
	sys-apps/sed"

RDEPEND="java? ( virtual/jdk )"
SRC_URI="http://www.hpcc.jp/${MY_PN}/ftp/${MY_PN}/${MY_P}.tar.gz"

src_compile() {
	local myconf=""

	# There is no configure script for the doc
	if ! use doc  ; then
	    dosed s/doc// Makefile.in
	fi

	use java && myconf="${myconf} --with-jvm=yes"
	use java || myconf="${myconf} --with-jvm=no"

	use doc && myconf="${myconf} --enable-installSample"

	# scoredoc is just about the placement of the doc
	econf ${myconf} --enable-gcc --disable-scoreDoc \
	                --with-thread=pthread || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	# Put the doc in the right place
	dodir /usr/share/doc/
	[ -d ${D}usr/lib/openmp/doc ] && mv ${D}usr/lib/openmp/doc ${D}usr/share/doc/${PF}
	[ -d ${D}usr/lib/openmp/examples ] && mv ${D}usr/lib/openmp/examples ${D}usr/share/doc/${PF}

	dodoc README COPYRIGHT LICENSE
}
