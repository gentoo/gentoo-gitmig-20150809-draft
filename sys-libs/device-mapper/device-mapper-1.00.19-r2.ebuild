# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/device-mapper/device-mapper-1.00.19-r2.ebuild,v 1.1 2005/02/23 04:06:58 azarah Exp $

inherit eutils

DESCRIPTION="Device mapper ioctl library for use with LVM2 utilities."
HOMEPAGE="http://sources.redhat.com/dm/"
SRC_URI="ftp://sources.redhat.com/pub/dm/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~amd64 ppc64 ~alpha hppa"
IUSE=""

DEPEND="virtual/linux-sources"

S="${WORKDIR}/${PN}.${PV}"

pkg_setup() {
	if [ ! -e "/usr/src/linux/include/linux/dm-ioctl.h" ] ; then
		eerror
		eerror "Your currently linked kernel (/usr/src/linux) hasn't"
		eerror "been patched for device mapper support."
		eerror
		die "kernel not patched for device mapper support"
	fi

	return 0
}

src_compile() {
	econf || die "econf failed"

	# Parallel build doesn't work.
	emake -j1 || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" \
		libdir="${D}/$(get_libdir)" || die "install failed"

	# Please do not use $(get_libdir) here again, as it is where it is
	# _located_, and not to where it is installed!
	dolib.a ${S}/lib/ioctl/libdevmapper.a
	# bug #4411
	gen_usr_ldscript libdevmapper.so || die "gen_usr_ldscript failed"

	insinto /etc
	doins ${FILESDIR}/dmtab
	insinto /lib/rcscripts/addons
	doins ${FILESDIR}/dm-start.sh

	dodoc COPYING* INSTALL INTRO README VERSION WHATS_NEW
}
