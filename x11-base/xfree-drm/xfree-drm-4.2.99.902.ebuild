# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.2.99.902.ebuild,v 1.1 2003/02/26 10:28:51 seemant Exp $

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
S=${WORKDIR}/linux/drm/kernel
DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://www.xfree.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-base/xfree-${PV}"

PROVIDE="virtual/drm"

pkg_setup() {
	
	check_KV
}

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo-Makefile-fixup.patch
}

src_compile() {

	check_KV

	einfo "Building DRM..."
	make -f Makefile.linux \
		TREE="/usr/src/linux/include" KV="${KV}"
}

src_install() {

	einfo "installing DRM..."
	make -f Makefile.linux \
		TREE="/usr/src/linux/include" \
		KV="${KV}" DESTDIR="${D}" \
		install || die

	dodoc README*
}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi
}
