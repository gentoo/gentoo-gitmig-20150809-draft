# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.3.0-r1.ebuild,v 1.2 2003/03/15 20:12:05 gerk Exp $

# PPC is using a drm only tarball here now.  The fixes we need (read hacks) don't exist
# in xfree trees (yet), and likely may not for a while due to the hackish nature of some
# of the requirements - Gerk - Feb 07 2003
# this build is meant for PPC only, portage eats digests otherwise

IUSE=""

inherit eutils

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://www.xfree.org"
LICENSE="X11"
SLOT="${KV}"
KEYWORDS="ppc -x86 -sparc -alpha -mips"

DEPEND=">=x11-base/xfree-${PV}"

PROVIDE="virtual/drm"

S="${WORKDIR}" 
SRC_URI="http://cvs.gentoo.org/~gerk/distfiles/drm-trunk.tar.gz"
MY_S="modules/drm-trunk"
MY_MODULES="r128.o radeon.o"

pkg_setup() {
	
	check_KV
}

src_unpack() {

	unpack drm-trunk.tar.gz
	epatch ${FILESDIR}/${P}-gentoo-ppc-Makefile-fixup.patch

}

src_compile() {

	check_KV
	einfo "Building DRM..."
	cd ${MY_S}
	# removed TREE variable, it uses the proper stuff from 
	# /lib/modules/*/include for running kernel by default
	make -f Makefile.linux ${MY_MODULES}  KV="${KV}" || die
}

src_install() {

	einfo "installing DRM..."
	cd ${MY_S}
	make -f Makefile.linux ${MY_MODULES} KV="${KV}" DESTDIR="${D}" \
		install || die
}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi
}

