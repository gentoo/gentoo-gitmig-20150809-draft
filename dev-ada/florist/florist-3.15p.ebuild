# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/florist/florist-3.15p.ebuild,v 1.1 2003/07/25 05:46:05 george Exp $

inherit gnat

DESCRIPTION="POSIX Ada Bindings"
HOMEPAGE="http://www.cs.fsu.edu/~baker/florist.html"
SRC_URI="ftp://cs.nyu.edu/pub/gnat/3.15p/florist-3.15p-src.tgz"

DEPEND="dev-lang/gnat"
RDEPEND=""
LICENSE="GMGPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${P}-src"

src_compile() {
	sed -i -e "s:GCST(\"SIGRTMAX\", SIGRTMAX:GCST(\"SIGRTMAX\", (NSIG - 1):" c-posix.c
	econf || die "./configure failed"

	emake \
		GCCFLAGS="${CFLAGS} -fPIC" \
		GNATMAKEFLAGS2B="-cargs -gnatpg ${ADACFLAGS} -fPIC -largs \$(LIBS)" \
		|| die

	# In addition we also generate the shared version of the library
	mkdir ${S}/t
	pushd ${S}/t
	ar xv ../floristlib/libflorist.a
	${ADAC} -shared -o ../floristlib/libflorist-${PV}.so.1 *.o
	cd ..
	rm -rf t
	popd
}

src_install() {
	dodoc README

	insinto /usr/lib/ada/adalib/florist
	doins floristlib/libflorist.a
	doins floristlib/libflorist-${PV}.so.1
	doins floristlib/*.ali

	insinto /usr/lib/ada/adainclude/florist
	doins floristlib/*.ads
	doins floristlib/*.adb

	cd ${D}/usr/lib/ada/adalib/florist
	ln -s libflorist-${PV}.so.1 libflorist.so
	cd ${S}
}

