# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/omni/omni-1.4a.ebuild,v 1.1 2003/06/03 13:03:24 tantive Exp $

DESCRIPTION="The Omni OpenMP Compiler"
HOMEPAGE="http://phase.etl.go.jp/Omni/"
LICENSE="Omni"
SLOT="0"
KEYWORDS="~x86"
S=${WORKDIR}/Omni-${PV}
A=Omni-${PV}.tar.gz

IUSE="java doc"

DEPEND="java? ( virtual/jdk
		app-arch/zip )
	sys-apps/sed"

RDEPEND="java? ( virtual/jdk )"

src_unpack() {

        if [ ! -e ${DISTDIR}/${A} ] ; then
                einfo "Due to license issues you have to download"
                einfo "the appropriate Omni archive:"
                einfo "http://phase.etl.go.jp/Omni/Omni-release.html"
		einfo "Please get the file "${A}
                einfo ""
                einfo "The archive should be placed into ${DISTDIR}."

                die "package archive not found"
        fi

	unpack ${A}


}

src_compile() {
	local myconf

	myconf=""

	# There is no configure script for the doc
	if [ ! `use doc` ]  ; then 
	    mv Makefile.in Makefile.in.orig
	    sed s/doc// Makefile.in.orig > Makefile.in
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
