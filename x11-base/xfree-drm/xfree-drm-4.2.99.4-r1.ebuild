# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.2.99.4-r1.ebuild,v 1.1 2003/02/08 21:17:16 gerk Exp $

# Small note:  we should prob consider using a DRM only tarball, as it will ease
#              some of the overhead on older systems, and will enable us to
#              update DRM if there are fixes not already in XFree86 tarballs ...

# PPC is using such a tarball here now.  The fixes we need (read hacks) don't exist
# in xfree trees (yet), and likely may not for a while due to the hackish nature
# Gerk - Feb 07 2003

IUSE=""

inherit eutils

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://www.xfree.org"
LICENSE="X11"
SLOT="0"
KEYWORDS="~ppc"

DEPEND=">=x11-base/xfree-${PV}"

PROVIDE="virtual/drm"

# different methods needed here for x86 + ppc, using pre-patched DRM tarball - Gerk
if [ `use x86` ] ; then  
	S="${WORKDIR}/xc"

	# Are we using a snapshot ?
	USE_SNAPSHOT="yes"

	BASE_PV="${PV}"

	SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${BASE_PV}/source"
	SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${BASE_PV}/source"
	# If we are using CVS snapshots made by Seemant ...
	SRC_PATH_SS="http://www.ibiblio.org/gentoo/gentoo-sources"

	if [ "${USE_SNAPSHOT}" = "yes" ]
	then
		SRC_URI="${SRC_PATH_SS}/X${BASE_PV}-1.tar.bz2
			${SRC_PATH_SS}/X${BASE_PV}-2.tar.bz2
			${SRC_PATH_SS}/X${BASE_PV}-3.tar.bz2
			${SRC_PATH_SS}/X${BASE_PV}-4.tar.bz2"
	else
		SRC_URI="${SRC_PATH0}/X${MY_SV}src-1.tgz
			${SRC_PATH0}/X${MY_SV}src-2.tgz
			${SRC_PATH0}/X${MY_SV}src-3.tgz
			${SRC_PATH1}/X${MY_SV}src-1.tgz
			${SRC_PATH1}/X${MY_SV}src-2.tgz
			${SRC_PATH1}/X${MY_SV}src-3.tgz"
	fi
	MY_S="${S}/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel"
	MY_MODULES=""  # can limit modules here or blank for all
fi

if [ `use ppc` ] ; then  
	S="${WORKDIR}" 
	SRC_URI="http://cvs.gentoo.org/~gerk/distfiles/drm-trunk.tar.gz"
	MY_S="modules/drm-trunk"
	#MY_MODULES="r128.o radeon.o"
fi

pkg_setup() {
	
	check_KV
}

src_unpack() {

	if [ `use x86` ] ; then
		if [ "${USE_SNAPSHOT}" = "yes" ]
		then
			unpack X${BASE_PV}-{1,2,3,4}.tar.bz2
		else
			unpack X${MY_SV}src-{1,2,3}.tgz
		fi
	
		cd ${S}
		epatch ${FILESDIR}/${P}-gentoo-Makefile-fixup.patch
	fi

	if [ `use ppc` ] ; then 
		unpack drm-trunk.tar.gz
		epatch ${FILESDIR}/${P}-gentoo-ppc-Makefile-fixup.patch
	fi

}

src_compile() {

	check_KV
	einfo "Building DRM..."
	cd ${MY_S}
	make -f Makefile.linux ${MY_MODULES} \
		TREE="/usr/src/linux/include" KV="${KV}" || die
}

src_install() {

	einfo "installing DRM..."
	cd ${MY_S}
	make -f Makefile.linux ${MY_MODULES} \
		TREE="/usr/src/linux/include" \
		KV="${KV}" DESTDIR="${D}" \
		install || die
}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi
}

