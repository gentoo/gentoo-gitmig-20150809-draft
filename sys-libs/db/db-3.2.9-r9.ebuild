# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-3.2.9-r9.ebuild,v 1.6 2003/09/07 14:15:46 pappy Exp $

IUSE="doc"

inherit libtool
inherit eutils
inherit db

S="${WORKDIR}/${P}"
DESCRIPTION="Berkeley DB for transaction support in MySQL"
SRC_URI="http://www.sleepycat.com/update/snapshot/${P}.tar.gz"
HOMEPAGE="http://www.sleepycat.com/"

SLOT="3"
LICENSE="DB"
# This ebuild is to be the compatibility ebuild for when db4 is put
# in the tree.
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

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

	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
	if has_version 'sys-devel/hardened-gcc' && [ "${CC}"="gcc" ]
	then
		CC="${CC} -yet_exec"
	fi

	# Fix invalid .la files
	cd ${WORKDIR}/${P}/dist
	rm -f ltversion.sh
	# remove config.guess else we have problems with gcc-3.2
	rm -f config.guess
	sed -i "s,\(-D_GNU_SOURCE\),\1 ${CFLAGS}," configure
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
	cp libdb.a libdb-3.2.a
	cp libdb_cxx.a libdb_cxx-3.2.a
	dolib.a libdb-3.2.a libdb_cxx-3.2.a

	db_src_install_headerslot

	# this is now done in the db eclass, function db_fix_so and db_src_install_usrlibcleanup
	#cd ${D}/usr/lib
	#ln -s libdb-3.2.so libdb.so.3

	# For some reason, db.so's are *not* readable by group or others,
	# resulting in no one but root being able to use them!!!
	# This fixes it -- DR 15 Jun 2001
	cd ${D}/usr/lib
	chmod go+rx *.so
	# The .la's aren't readable either
	chmod go+r *.la

	cd ${S}
	dodoc README LICENSE

	db_src_install_doc

	db_src_install_usrbinslot

	db_src_install_usrlibcleanup
}

pkg_postinst () {
	db_fix_so
}

pkg_postrm () {
	db_fix_so
}

