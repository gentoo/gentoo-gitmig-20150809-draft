# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-4.1.25_p1.ebuild,v 1.2 2003/09/04 08:04:42 msterret Exp $

IUSE="tcltk java"

#Number of official patches
PATCHNO=`echo ${PV}|sed -e "s,\(.*_p\)\([0-9]*\),\2,"`
if [ "${PATCHNO}" == "${PV}" ]; then
	MY_PV=${PV}
	MY_P=${P}
	PATCHNO=0
else
	MY_PV=${PV/_p${PATCHNO}}
	MY_P=${PN}-${MY_PV}
fi

S=${WORKDIR}/${MY_P}/build_unix
DESCRIPTION="Berkeley DB"
SRC_URI="http://www.sleepycat.com/update/snapshot/${MY_P}.tar.gz"

for (( i=1 ; i<=$PATCHNO ; i++ ))
do
	export SRC_URI="${SRC_URI} http://www.sleepycat.com/update/${MY_PV}/patch.${MY_PV}.${i}"
done

HOMEPAGE="http://www.sleepycat.com"
SLOT="4.1"
LICENSE="DB"
KEYWORDS="amd64"

DEPEND="tcltk? ( dev-lang/tcl )
	java? ( virtual/jdk )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${WORKDIR}/${MY_P}
	for (( i=1 ; i<=$PATCHNO ; i++ ))
	do
		patch -p0 <${DISTDIR}/patch.${MY_PV}.${i}
	done
}

src_compile() {

	local myconf

	use java \
		&& myconf="${myconf} --enable-java" \
		|| myconf="${myconf} --disable-java"

	use tcltk \
		&& myconf="${myconf} --enable-tcl --with-tcl=/usr/lib" \
		|| myconf="${myconf} --disable-tcl"

	if [ -n "${JAVAC}" ]; then
		export PATH=`dirname ${JAVAC}`:${PATH}
		export JAVAC=`basename ${JAVAC}`
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

	emake || make || die
}

src_install () {

	einstall || die
	for fname in ${D}/usr/bin/db_*
	do
		mv ${fname} ${fname//\/db_/\/db${SLOT}_}
	done

	dodir /usr/include/db${SLOT}
	mv ${D}/usr/include/*.h ${D}/usr/include/db${SLOT}/

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/docs/* ${D}/usr/share/doc/${PF}/html/
	ln -s /usr/include/db${SLOT}/db.h ${D}/usr/include/db.h
}

fix_so () {

	cd ${ROOT}/usr/lib
	target=`find -type f -maxdepth 1 -name "libdb-*.so" |sort |tail -n 1`
	[ -n "${target}" ] && ln -sf ${target//.\//} libdb.so
	target=`find -type f -maxdepth 1 -name "libdb_cxx*.so" |sort |tail -n 1`
	[ -n "${target}" ] && ln -sf ${target//.\//} libdb_cxx.so
	target=`find -type f -maxdepth 1 -name "libdb_tcl*.so" |sort |tail -n 1`
	[ -n "${target}" ] && ln -sf ${target//.\//} libdb_tcl.so
	target=`find -type f -maxdepth 1 -name "libdb_java*.so" |sort |tail -n 1`
	[ -n "${target}" ] && ln -sf ${target//.\//} libdb_java.so

	cd ${ROOT}/usr/include
	target=`ls -d db? |sort|tail -n 1`
	[ -n "${target}" ] && ln -sf ${target}/db.h .
	[ -n "${target}" ] && ln -sf ${target}/db_185.h .
}

pkg_postinst () {
	fix_so
}

pkg_postrm () {
	fix_so
}
