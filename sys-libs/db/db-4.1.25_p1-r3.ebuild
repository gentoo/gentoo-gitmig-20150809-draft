# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-4.1.25_p1-r3.ebuild,v 1.28 2004/11/30 19:37:20 pauldv Exp $

inherit eutils gnuconfig db

#Number of official patches
#PATCHNO=`echo ${PV}|sed -e "s,\(.*_p\)\([0-9]*\),\2,"`
PATCHNO=${PV/*.*.*_p}
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
HOMEPAGE="http://www.sleepycat.com"
SRC_URI="http://www.sleepycat.com/update/snapshot/${MY_P}.tar.gz"
for (( i=1 ; i<=$PATCHNO ; i++ ))
do
	export SRC_URI="${SRC_URI} http://www.sleepycat.com/update/${MY_PV}/patch.${MY_PV}.${i}"
done

LICENSE="DB"
SLOT="4.1"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 sh"
IUSE="tcltk java doc"

DEPEND="tcltk? ( dev-lang/tcl )
	java? ( virtual/jdk )"

RDEPEND="tcltk? ( dev-lang/tcl )
	java? ( virtual/jre )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${WORKDIR}/${MY_P}
	for (( i=1 ; i<=$PATCHNO ; i++ ))
	do
		epatch ${DISTDIR}/patch.${MY_PV}.${i}
	done
	epatch ${FILESDIR}/${P}-jarlocation.patch

	epatch ${FILESDIR}/${PN}-4.0.14-fix-dep-link.patch
	epatch ${FILESDIR}/${PN}-4.1.25-uclibc.patch
	epatch ${FILESDIR}/${PN}-4.1.25-java.patch
	gnuconfig_update "${S}/../dist"
}

src_compile() {
	addwrite /proc/self/maps

	local myconf="--enable-rpc"

	use amd64 && myconf="${myconf} --with-mutex=x86/gcc-assembly"

	use java \
		&& myconf="${myconf} --enable-java" \
		|| myconf="${myconf} --disable-java"

	use tcltk \
		&& myconf="${myconf} --enable-tcl --with-tcl=/usr/$(get_libdir)" \
		|| myconf="${myconf} --disable-tcl"

	if use java && [ -n "${JAVAC}" ]; then
		export PATH=`dirname ${JAVAC}`:${PATH}
		export JAVAC=`basename ${JAVAC}`
	fi

	[ -n "${CBUILD}" ] && myconf="${myconf} --build=${CBUILD}"

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
		--host=${CHOST} \
		${myconf} || die

	emake || make || die
}

src_install () {

	einstall || die

	db_src_install_usrbinslot

	db_src_install_headerslot

	db_src_install_doc

	db_src_install_usrlibcleanup

	dodir /usr/sbin
	mv ${D}/usr/bin/berkeley_db_svc ${D}/usr/sbin/berkeley_db41_svc
}

pkg_postinst () {
	db_fix_so
}

pkg_postrm () {
	db_fix_so
}
