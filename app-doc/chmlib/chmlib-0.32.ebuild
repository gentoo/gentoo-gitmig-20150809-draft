# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/chmlib/chmlib-0.32.ebuild,v 1.7 2004/09/02 22:43:03 pvdabeel Exp $

DESCRIPTION="Library for MS CHM (compressed html) file format plus extracting and http server utils"
HOMEPAGE="http://66.93.236.84/~jedwin/projects/chmlib/"
SRC_URI="http://66.93.236.84/~jedwin/projects/chmlib/${PF}.tgz"
DEPEND=">=sys-apps/sed-4"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ppc ~amd64"
IUSE=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -r "s,(\\\$\\{INSTALLPREFIX\\}),\${DESTDIR}\\1,g;s,@LIBTOOL@,libtool,g" Makefile.in
	econf || die "econf failed"
#	sed -i "s:gcc-3.2:gcc:" Makefile
#	sed -i "s:/usr/local/:/${D}/usr/:" Makefile
	if [ "${ARCH}" = "ppc" ]; then
		# In this case it is safe to take this rather
		# stupid action =)
		sed -i "s:__i386__:__powerpc__:" src/chm_lib.c
	fi
	if [ "${ARCH}" == "amd64" ]; then
		sed -i "s:__i386__:__x86_64__:" src/chm_lib.c
	fi
}

src_compile() {
	emake || die
}

src_install() {
	#Make expects to find these dirs.
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/include
	dodir /usr/share/doc/${PF}/examples/

	make install DESTDIR=${D}

	#Build additional utils, making this lib useful by itself.
	#This cannot be build in src_compile as it needs to find chmlib.
	emake extract_chmLib DESTDIR=${D} || die
	emake chm_http DESTDIR=${D} || die
	exeinto /usr/bin
	newexe extract_chmLib chmextract
	newexe chm_http chmhttp

	#Install examples as well.
	insinto /usr/share/doc/${PF}/examples/
	doins src/test_chmLib.c src/enum_chmLib.c src/chm_http.c

	dodoc AUTHORS NEWS README
}
