# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-3.2.9-r5.ebuild,v 1.2 2003/05/24 12:18:37 pauldv Exp $

IUSE=""

inherit libtool
inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Berkeley DB for transaction support in MySQL"
SRC_URI="http://www.sleepycat.com/update/snapshot/${P}.tar.gz"
HOMEPAGE="http://www.sleepycat.com/"

SLOT="3"
LICENSE="DB"
# This ebuild is to be the compatibility ebuild for when db4 is put
# in the tree.
KEYWORDS="-x86 -ppc -sparc -alpha -mips -hppa -arm"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	=sys-libs/db-1.85-r1
	sys-devel/libtool
	sys-devel/m4"
# We need m4 too else build fails without config.guess

# This doesn't build without exceptions
export CXXFLAGS="${CXXFLAGS/-fno-exceptions/-fexceptions}"

src_unpack() {
	unpack ${A}
	
	chmod -R ug+w *

	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/patch.3.2.9.1
	epatch ${FILESDIR}/patch.3.2.9.2

	# Get db to link libdb* to correct dependencies ... for example if we use
	# NPTL or NGPT, db detects usable mutexes, and should link against
	# libpthread, but does not do so ...
	# <azarah@gentoo.org> (23 Feb 2003)
	epatch ${FILESDIR}/${P}-fix-dep-link.patch

	# We should get dump185 to link against system db1 ..
	# <azarah@gentoo.org> (23 Feb 2003)
	mv ${S}/dist/Makefile.in ${S}/dist/Makefile.in.orig
	sed -e 's:DB185INC=:DB185INC= -I/usr/include/db1:' \
		-e 's:DB185LIB=:DB185LIB= -ldb1:' \
		${S}/dist/Makefile.in.orig > ${S}/dist/Makefile.in || die "Failed to sed"

	# Fix invalid .la files
	cd ${WORKDIR}/${P}/dist
	rm -f ltversion.sh
	# remove config.guess else we have problems with gcc-3.2
	rm -f config.guess
}

src_compile() {
	local conf=

	conf="--host=${CHOST} \
		--build=${CHOST} \
		--enable-cxx \
		--enable-compat185 \
		--enable-dump185 \
		--prefix=/usr"
	# --enable-rpc aparently does not work .. should verify this
	# at some stage ...
	
	# NOTE: we should not build both shared and static versions
	#       of the libraries in the same build root!

	einfo "Configuring ${P} (static)..."
	mkdir -p ${S}/build-static
	cd ${S}/build-static
	../dist/configure ${conf} \
		--enable-static || die

	einfo "Configuring ${P} (shared)..."
	mkdir -p ${S}/build-shared
	cd ${S}/build-shared
	../dist/configure ${conf} \
		--enable-shared || die
		
	# Parallel make does not work
	MAKEOPTS="${MAKEOPTS} -j1"
	einfo "Building ${P} (static)..."
	cd ${S}/build-static
	emake || die "Static build failed"
	einfo "Building ${P} (shared)..."
	cd ${S}/build-shared
	emake || die "Shared build failed"
}

src_install () {
	cd ${S}/build-shared
	make libdb=libdb-3.2.a \
		libcxx=libcxx_3.2.a \
		prefix=${D}/usr \
		install || die
	
	cd ${S}/build-static
	dolib.a libdb-3.2.a libdb_cxx-3.2.a

	dodir usr/include/db3
	cd ${D}/usr/include
	mv *.h db3
	ln db3/db.h db.h
	
	cd ${D}/usr/lib
	ln -s libdb-3.2.so libdb.so.3

	# For some reason, db.so's are *not* readable by group or others,
	# resulting in no one but root being able to use them!!!
	# This fixes it -- DR 15 Jun 2001
	cd ${D}/usr/lib
	chmod go+rx *.so
	# The .la's aren't readable either
	chmod go+r *.la
	
	cd ${S}
	dodoc README LICENSE

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/docs/* ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/docs

	#making things work better with the db4 ebuild
	for fname in ${D}/usr/bin/db_*
	do
		mv ${fname} ${fname//\/db_/\/db4_}
	done
	ln -sf /usr/include/db4/db.h ${D}/usr/include/db.h
}

fix_so () {
	cd /usr/lib
	target=`find -type f -maxdepth 1 -name "libdb-*.so" |tail -n 1`
	[ ${target} ] && ln -sf ${target//.\//} libdb.so
	target=`find -type f -maxdepth 1 -name "libdb_cxx*.so" |tail -n 1`
	[ ${target} ] && ln -sf ${target//.\//} libdb_cxx.so
	target=`find -type f -maxdepth 1 -name "libdb_tcl*.so" |tail -n 1`
	[ ${target} ] && ln -sf ${target//.\//} libdb_tcl.so
	cd -
	cd /usr/include
	target=`ls db? |tail -n 1`
	[ ${target} ] && ln -sf ${target}/db.h .
	cd -
}

pkg_postinst () {
	fix_so
}

pkg_postrm () {
	fix_so
}

