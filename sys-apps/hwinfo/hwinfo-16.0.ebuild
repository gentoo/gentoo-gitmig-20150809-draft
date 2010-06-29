# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwinfo/hwinfo-16.0.ebuild,v 1.5 2010/06/29 18:29:21 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="hwinfo is the hardware detection tool used in SuSE Linux."
HOMEPAGE="http://www.suse.com"
DEBIAN_PV="2"
DEBIAN_BASE_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/"
SRC_URI="${DEBIAN_BASE_URI}/${PN}_${PV}.orig.tar.gz
		 ${DEBIAN_BASE_URI}/${PN}_${PV}-${DEBIAN_PV}.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND=">=sys-fs/sysfsutils-2
		sys-apps/hal
		sys-apps/dbus"
# this package won't work on *BSD
DEPEND="${RDEPEND}
		>=sys-kernel/linux-headers-2.6.17"

src_unpack (){
	unpack ${PN}_${PV}.orig.tar.gz
}

src_prepare() {
	EPATCH_OPTS="-p1 -d ${S}" epatch "${DISTDIR}"/${PN}_${PV}-${DEBIAN_PV}.diff.gz
	cd "${S}"
	for i in $(<"${S}"/debian/patches/series) ; do
		EPATCH_SUFFIX="" EPATCH_FORCE="yes" epatch "${S}"/debian/patches/${i}
	done
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-13.11-makefile-fixes.patch
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-16.0-parallel-fixes.patch
	#sed -i -e "s,^LIBS[ \t]*= -lhd,LIBS = -lhd -lsysfs," ${S}/Makefile
	#sed -i -e "s,^LIBDIR[ \t]*= /usr/lib$,LIBDIR = /usr/$(get_libdir)," ${S}/Makefile
	sed -i -e 's,make,$(MAKE),g' "${S}"/Makefile "${S}"/Makefile.common
	sed -i -e '/^touch:/s,$, $(LIBHD),g' "${S}"/src/Makefile
	sed -i -e '/^hw[a-z]\+:.*$(LIBHD)/s,$, subdirs ranlib,g' "${S}"/Makefile
	echo '$(LIBHD): subdirs' >>"${S}"/Makefile
	for i in src/{,ids,hd,isdn,isdn/cdb,int10,smp} ; do
		echo 'objects: $(OBJS) $(LIBHD)' >>"${S}"/${i}/Makefile
		echo '$(OBJS): subdirs' >>"${S}"/${i}/Makefile
		echo 'libs: $(LIBHD) subdirs $(OBJS)' >>"${S}"/${i}/Makefile
	done

	echo 'libs:' >>"${S}"/src/x86emu/Makefile

	echo 'libs: subdirs' >>"${S}"/Makefile
	echo 'ranlib: $(LIBHD) subdirs' >>"${S}"/Makefile
	echo -e "\tranlib \$(LIBHD)" >>"${S}"/Makefile

	sed -i -e 's/LDFLAGS	= /LDFLAGS := $(LDFLAGS) /' "${S}"/Makefile.common || die
	sed -i -e 's/(CFLAGS)/& $(LDFLAGS)/' "${S}"/src/ids/Makefile || die
	epatch "${FILESDIR}"/${PN}-16.0-asneeded.patch
}

src_compile(){
	# build is NOT parallel safe, and the build system blows goats
	einfo "ISDN CDB pass"
	emake EXTRA_FLAGS="${CFLAGS}" -C 'src/isdn/cdb' || die "emake failed"
	einfo "LIBS pass"
	emake EXTRA_FLAGS="${CFLAGS}" libs || die "emake failed"
	einfo "FINAL pass"
	emake -j1 EXTRA_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	[[ "$(get_libdir)" != "lib" ]] && mv "${D}"/usr/lib "${D}/usr/$(get_libdir)"
	dodoc VERSION README
	doman doc/hwinfo.8
}
