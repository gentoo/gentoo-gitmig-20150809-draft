# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.2.99.3.ebuild,v 1.3 2003/02/13 16:54:16 vapier Exp $

# Small note:  we should prob consider using a DRM only tarball, as it will ease
#              some of the overhead on older systems, and will enable us to
#              update DRM if there are fixes not already in XFree86 tarballs ...

IUSE=""

inherit eutils

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

# Are we using a snapshot ?
USE_SNAPSHOT="yes"

BASE_PV="${PV}"
S="${WORKDIR}/xc"
DESCRIPTION="Xfree86 Kernel DRM modules"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${BASE_PV}/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${BASE_PV}/source"
# If we are using CVS snapshots made by Seemant ...
SRC_PATH_SS="http://www.ibiblio.org/gentoo/gentoo-sources"
HOMEPAGE="http://www.xfree.org"

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

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-base/xfree-${PV}"

PROVIDE="virtual/drm"

pkg_setup() {
	
	check_KV
}

src_unpack() {

	if [ "${USE_SNAPSHOT}" = "yes" ]
	then
		unpack X${BASE_PV}-{1,2,3,4}.tar.bz2
	else
		unpack X${MY_SV}src-{1,2,3}.tgz
	fi

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-Makefile-fixup.patch
}

src_compile() {

	check_KV

	einfo "Building DRM..."
	cd ${S}/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel
	make -f Makefile.linux \
		TREE="/usr/src/linux/include" KV="${KV}"
}

src_install() {

	einfo "installing DRM..."
	cd ${S}/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel
	make -f Makefile.linux \
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

