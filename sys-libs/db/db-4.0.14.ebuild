# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-4.0.14.ebuild,v 1.19 2003/05/25 18:49:13 pauldv Exp $

IUSE="tcltk java"

S=${WORKDIR}/${P}/build_unix
DESCRIPTION="Berkeley DB"
SRC_URI="http://www.sleepycat.com/update/snapshot/${P}.tar.gz"
HOMEPAGE="http://www.sleepycat.com"
SLOT="4"
LICENSE="DB"
KEYWORDS="-x86 -ppc -sparc "

DEPEND="tcltk? ( dev-lang/tcl )
	java? ( virtual/jdk )"

src_compile() {

	local myconf

	use java \
		&& myconf="${myconf} --enable-java" \
		|| myconf="${myconf} --disable-java"

	use tcltk \
		&& myconf="${myconf} --enable-tcl --with-tcl=/usr/lib" \
		|| myconf="${myconf} --disable-tcl"
	
	if [ -n "${JAVAC}" ]; then
		export JAVAC=`basename ${JAVAC}`
		export PATH=`dirname ${JAVAC}`:${PATH}
	fi
	
	../dist/configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-compat185 \
		--enable-cxx \
		--with-uniquename \
		${myconf} || die

#	disable posix mutexes as they are not available in linuxthreads from
#	the standard profile and they should be autodetected if available
#
#		--enable-posixmutexes \

	emake || make || die
}

src_install () {

	einstall || die
	for fname in ${D}/usr/bin/db_*
	do
		mv ${fname} ${fname//\/db_/\/db4_}
	done

	dodir /usr/include/db4
	mv ${D}/usr/include/*.h ${D}/usr/include/db4/

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/docs/* ${D}/usr/share/doc/${PF}/html/
	ln -s /usr/include/db4/db.h ${D}/usr/include/db.h
}

fix_so () {
	cd /usr/lib
	target=`find -type f -maxdepth 1 -name "libdb-*.so" |sort |tail -n 1`
	[ ${target} ] && ln -sf ${target//.\//} libdb.so
	target=`find -type f -maxdepth 1 -name "libdb_cxx*.so" |sort |tail -n 1`
	[ ${target} ] && ln -sf ${target//.\//} libdb_cxx.so
	target=`find -type f -maxdepth 1 -name "libdb_tcl*.so" |sort |tail -n 1`
	[ ${target} ] && ln -sf ${target//.\//} libdb_tcl.so
	target=`find -type f -maxdepth 1 -name "libdb_java*.so" |sort |tail -n 1`
	[ ${target} ] && ln -sf ${target//.\//} libdb_java.so
	cd -
	cd /usr/include
	target=`ls -d db? |tail -n 1`
	[ ${target} ] && ln -sf ${target}/db.h .
	cd -
}

pkg_postinst () {
	fix_so
}

pkg_postrm () {
	fix_so
}
