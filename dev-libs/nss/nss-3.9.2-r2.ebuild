# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nss/nss-3.9.2-r2.ebuild,v 1.1 2004/11/25 15:55:04 lv Exp $

inherit eutils

RTM_NAME="NSS_${PV//./_}_RTM"
DESCRIPTION="Mozilla's Netscape Security Services Library that implements PKI support"
HOMEPAGE="http://www.mozilla.org/projects/security/pki/nss/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/${RTM_NAME}/src/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc"
IUSE=""

DEPEND="virtual/libc
	app-arch/zip
	>=dev-libs/nspr-4.4.1-r2"

src_unpack() {
	unpack ${A}

	# hack nspr paths
	echo 'INCLUDES += -I${ROOT}usr/include/nspr -I$(DIST)/include/dbm' \
		>> ${S}/mozilla/security/coreconf/headers.mk || die "failed to append include"

	sed -e 's:$(DIST)/lib/$(LIB_PREFIX)plc4:${ROOT}usr/'"$(get_libdir)"'/nspr/$(LIB_PREFIX)plc4:' \
		-e 's:$(DIST)/lib/$(LIB_PREFIX)plds4:${ROOT}usr/'"$(get_libdir)"'/nspr/$(LIB_PREFIX)plds4:' \
		-i ${S}/mozilla/security/nss/lib/ckfw/builtins/Makefile
	sed -e 's:$(DIST)/lib/$(LIB_PREFIX)plc4:${ROOT}usr/'"$(get_libdir)"'/nspr/$(LIB_PREFIX)plc4:' \
		-e 's:$(DIST)/lib/$(LIB_PREFIX)plds4:${ROOT}usr/'"$(get_libdir)"'/nspr/$(LIB_PREFIX)plds4:' \
		-i ${S}/mozilla/security/nss/lib/fortcrypt/swfort/pkcs11/Makefile

	# cope with nspr being in /usr/$(get_libdir)/nspr
	sed -e 's:-L$(DIST)/lib.:-L$(DIST)/lib/ -L/usr/'"$(get_libdir)"'/nspr/ :g' \
		-i ${S}/mozilla/security/nss/lib/ckfw/builtins/Makefile \
		-i ${S}/mozilla/security/nss/lib/ckfw/builtins/manifest.mn \
		-i ${S}/mozilla/security/nss/lib/ckfw/dbm/manifest.mn \
		-i ${S}/mozilla/security/nss/cmd/platlibs.mk \
		-i ${S}/mozilla/security/nss/cmd/pkiutil/platlibs.mk \
		-i ${S}/mozilla/security/nss/lib/fortcrypt/swfort/pkcs11/Makefile \
		-i ${S}/mozilla/security/nss/lib/freebl/config.mk \
		-i ${S}/mozilla/security/nss/lib/nss/config.mk \
		-i ${S}/mozilla/security/nss/lib/smime/config.mk \
		-i ${S}/mozilla/security/nss/lib/softoken/config.mk \
		-i ${S}/mozilla/security/nss/lib/ssl/config.mk

	# modify install path
	sed -e 's:SOURCE_PREFIX = $(CORE_DEPTH)/\.\./dist:SOURCE_PREFIX = $(CORE_DEPTH)/dist:' \
		-i ${S}/mozilla/security/coreconf/source.mk

	cd ${S}; epatch ${FILESDIR}/${PN}-${PV}-ppc64.patch
}

src_compile() {
	cd ${S}/mozilla/security/coreconf

	emake -j1 BUILD_OPT=1 || die "coreconf make failed"
	cd ${S}/mozilla/security/dbm
	emake -j1 BUILD_OPT=1 || die "dbm make failed"
	cd ${S}/mozilla/security/nss
	emake -j1 BUILD_OPT=1 || die "nss make failed"
}

src_install () {
	cd ${S}/mozilla/security/dist

	# put all *.a files in /usr/lib/nss (because some have conflicting names
	# with existing libraries)
	dodir /usr/$(get_libdir)/nss
	cp -L */lib/*.a ${D}/usr/$(get_libdir)/nss || die "copying libs failed"
	cp -L */lib/*.so ${D}/usr/$(get_libdir)/nss || die "copying shared libs failed"

	# all the include files
	insinto /usr/include/nss
	doins private/nss/*.h
	doins public/nss/*.h

	# coping with nss being in a different path
	dodir /etc/env.d
	echo "LDPATH=/usr/$(get_libdir)/nss" > ${D}/etc/env.d/50nss

	# NOTE: we ignore the binary files
}
