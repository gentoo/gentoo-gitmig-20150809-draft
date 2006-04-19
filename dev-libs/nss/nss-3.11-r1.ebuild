# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nss/nss-3.11-r1.ebuild,v 1.4 2006/04/19 02:30:35 anarchy Exp $

inherit eutils

NSPR_VER="4.6.1-r2"
RTM_NAME="NSS_${PV//./_}_RTM"
DESCRIPTION="Mozilla's Netscape Security Services Library that implements PKI support"
HOMEPAGE="http://www.mozilla.org/projects/security/pki/nss/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/${RTM_NAME}/src/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	app-arch/zip
	>=dev-libs/nspr-${NSPR_VER}"

src_unpack() {
	unpack ${A}

	# hack nspr paths
	echo 'INCLUDES += -I${ROOT}/usr/include/nspr -I$(DIST)/include/dbm' \
		>> ${S}/mozilla/security/coreconf/headers.mk || die "failed to append include"

	# cope with nspr being in /usr/$(get_libdir)/nspr
	sed -e 's:$(DIST)/lib:${ROOT}/usr/'"$(get_libdir)"/nspr':' \
		-i ${S}/mozilla/security/coreconf/location.mk

	# modify install path
	sed -e 's:SOURCE_PREFIX = $(CORE_DEPTH)/\.\./dist:SOURCE_PREFIX = $(CORE_DEPTH)/dist:' \
		-i ${S}/mozilla/security/coreconf/source.mk

	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}-zdefs.patch
	epatch ${FILESDIR}/${PN}-${PV}-config.patch
	epatch ${FILESDIR}/${PN}-${PV}-config-1.patch
	epatch ${FILESDIR}/${PN}-mips64.patch
}

src_compile() {
	if use amd64 || use ppc64 || use ia64 || use s390; then
		export USE_64=1
	fi
	export NSDISTMODE=copy
	cd ${S}/mozilla/security/coreconf
	emake -j1 BUILD_OPT=1 || die "coreconf make failed"
	cd ${S}/mozilla/security/dbm
	emake -j1 BUILD_OPT=1 || die "dbm make failed"
	cd ${S}/mozilla/security/nss
	emake -j1 BUILD_OPT=1 || die "nss make failed"
}

src_install () {
	MINOR_VERSION=11
	cd ${S}/mozilla/security/dist

	# put all *.a files in /usr/lib/nss (because some have conflicting names
	# with existing libraries)
	dodir /usr/$(get_libdir)/nss
	cp -L */lib/*.so ${D}/usr/$(get_libdir)/nss || die "copying shared libs failed"
	cp -L */lib/*.chk ${D}/usr/$(get_libdir)/nss || die "copying chk files failed"
	cp -L */lib/*.a ${D}/usr/$(get_libdir)/nss || die "copying libs failed"

	# all the include files
	insinto /usr/include/nss
	doins private/nss/*.h
	doins public/nss/*.h
	cd ${D}/usr/$(get_libdir)/nss
	for file in *.so; do
		mv ${file} ${file}.${MINOR_VERSION}
		ln -s ${file}.${MINOR_VERSION} ${file}
	done

	# coping with nss being in a different path. We move up priority to
	# ensure that nss/nspr are used specifically before searching elsewhere.
	dodir /etc/env.d
	echo "LDPATH=/usr/$(get_libdir)/nss" > ${D}/etc/env.d/08nss

	dodir /usr/bin
	dodir /usr/$(get_libdir)/pkgconfig
	cp ${FILESDIR}/nss-config.in ${D}/usr/bin/nss-config
	cp ${FILESDIR}/nss.pc.in ${D}/usr/$(get_libdir)/pkgconfig/nss.pc
	NSS_VMAJOR=`cat ${S}/mozilla/security/nss/lib/nss/nss.h | grep "#define.*NSS_VMAJOR" | awk '{print $3}'`
	NSS_VMINOR=`cat ${S}/mozilla/security/nss/lib/nss/nss.h | grep "#define.*NSS_VMINOR" | awk '{print $3}'`
	NSS_VPATCH=`cat ${S}/mozilla/security/nss/lib/nss/nss.h | grep "#define.*NSS_VPATCH" | awk '{print $3}'`

	sed -e "s,@libdir@,/usr/"$(get_libdir)"/nss,g" \
		-e "s,@prefix@,/usr,g" \
		-e "s,@exec_prefix@,\$\{prefix},g" \
		-e "s,@includedir@,\$\{prefix}/include/nss,g" \
		-e "s,@MOD_MAJOR_VERSION@,$NSS_VMAJOR,g" \
		-e "s,@MOD_MINOR_VERSION@,$NSS_VMINOR,g" \
		-e "s,@MOD_PATCH_VERSION@,$NSS_VPATCH,g" \
		-i ${D}/usr/bin/nss-config
	chmod 755 ${D}/usr/bin/nss-config

	sed -e "s,@libdir@,/usr/"$(get_libdir)"/nss,g" \
	      -e "s,@prefix@,/usr,g" \
	      -e "s,@exec_prefix@,\$\{prefix},g" \
	      -e "s,@includedir@,\$\{prefix}/include/nss," \
	      -e "s,@NSPR_VERSION@,`nspr-config --version`,g" \
	      -e "s,@NSS_VERSION@,$NSS_VMAJOR.$NSS_VMINOR.$NSS_VPATCH,g" \
	      -i ${D}/usr/$(get_libdir)/pkgconfig/nss.pc
	chmod 644 ${D}/usr/$(get_libdir)/pkgconfig/nss.pc
}
