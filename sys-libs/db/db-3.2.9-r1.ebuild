# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-3.2.9-r1.ebuild,v 1.13 2003/06/21 22:06:04 drobbins Exp $

S=${WORKDIR}/${P}/build_unix
DESCRIPTION="Berkeley DB for transaction support in MySQL"
SRC_URI="http://www.sleepycat.com/update/snapshot/${P}.tar.gz"
HOMEPAGE="http://www.sleepycat.com/"

SLOT="3"
LICENSE="DB"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa arm"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	=sys-libs/db-1.85-r1
	sys-devel/libtool
	sys-devel/m4"
# We need m4 to else build fails without config.guess

# this doesnt build without exceptions
export CXXFLAGS="${CXXFLAGS/-fno-exceptions/-fexceptions}"

src_unpack() {
	unpack ${A}
	chmod -R ug+w *
	
	cd ${WORKDIR}/${P}
	patch -p0 < ${FILESDIR}/patch.3.2.9.1 || die
	patch -p0 < ${FILESDIR}/patch.3.2.9.2 || die

	# fix invalid .la files
	cd ${WORKDIR}/${P}/dist
	rm -f ltversion.sh
	cp ${ROOT}/usr/share/libtool/ltmain.sh . || \
		die "Could not update ltmain.sh"
	# remove config.guess else we have problems with gcc-3.2
	rm -f config.guess
}

src_compile() {
	../dist/configure --host=${CHOST} \
		--build=${CHOST} \
		--enable-compat185 \
		--enable-dump185 \
		--prefix=/usr \
		--enable-shared \
		--enable-static \
		--enable-cxx || die
		
	#--enable-rpc does not work
	echo
	# Parallel make does not work
	einfo "Building static libs..."
	emake libdb=libdb-3.2.a libdb-3.2.a || die
	emake libcxx=libdb_cxx-3.2.a libdb_cxx-3.2.a || die
	echo
	einfo "Building db_dump185..."
	/bin/sh ./libtool --mode=compile ${CC} -c ${CFLAGS} -D_GNU_SOURCE \
		-I/usr/include/db1 -I../dist/../include -D_REENTRANT \
		../dist/../db_dump185/db_dump185.c || die
	gcc -s -static -o db_dump185 db_dump185.lo -L/usr/lib -ldb1 || die
	echo
	einfo "Building everything else..."
	MAKEOPTS="${MAKEOPTS} -j1"
	emake libdb=libdb-3.2.a libcxx=libdb_cxx-3.2.a || die
}

src_install () {
	make libdb=libdb-3.2.a \
		libcxx=libcxx_3.2.a \
		prefix=${D}/usr \
		install || die
		
	dolib.a libdb-3.2.a libdb_cxx-3.2.a

	dodir usr/include/db3
	cd ${D}/usr/include
	mv *.h db3
	ln db3/db.h db.h
	
	cd ${D}/usr/lib
	ln -s libdb-3.2.so libdb.so.3

	#for some reason, db.so's are *not* readable by group or others, resulting in no one
	#but root being able to use them!!! This fixes it -- DR 15 Jun 2001
	cd ${D}/usr/lib
	chmod go+rx *.so
	#.la's aren't go readable either
	chmod go+r *.la
	
	cd ${S}/..
	dodoc README LICENSE

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/docs/* ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/docs
}

