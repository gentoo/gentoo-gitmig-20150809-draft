# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/omni/omni-1.4a.ebuild,v 1.4 2004/02/11 08:31:02 seemant Exp $

IUSE="java doc"

MY_P=Omni-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Omni OpenMP Compiler"
HOMEPAGE="http://phase.hpcc.jp/Omni/home.html"

SLOT="0"
LICENSE="Omni"
KEYWORDS="x86"

RESTRICT="fetch"

DEPEND="java? ( virtual/jdk
	app-arch/zip )
	sys-apps/sed"

RDEPEND="java? ( virtual/jdk )"

src_unpack() {

	if [ ! -e ${DISTDIR}/${MY_P}.tar.gz ] ; then
		einfo "Due to license issues you have to download"
		einfo "the appropriate Omni archive:"
		einfo "http://phase.etl.go.jp/Omni/Omni-release.html"
		einfo "Please get the file "${MY_P}.tar.gz
		einfo ""
		einfo "The archive should be placed into ${DISTDIR}."

		die "package archive not found"
	fi

	unpack ${MY_P}.tar.gz


}

src_compile() {
	local myconf

	myconf=""

	# There is no configure script for the doc
	if [ ! `use doc` ]  ; then
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
	make DESTDIR=${D} install || die


	# Put the doc in the right place
	dodir /usr/share/doc/
	use doc && mv ${D}usr/lib/openmp/doc ${D}usr/share/doc/${P}
	use doc && mv ${D}usr/lib/openmp/examples ${D}usr/share/doc/${P}

	dodoc README COPYRIGHT LICENSE
}
