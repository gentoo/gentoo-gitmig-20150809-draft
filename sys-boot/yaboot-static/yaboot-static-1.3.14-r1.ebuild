# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot-static/yaboot-static-1.3.14-r1.ebuild,v 1.5 2015/05/17 03:55:10 vapier Exp $

inherit eutils

DESCRIPTION="Static yaboot ppc boot loader for machines with open firmware"

HOMEPAGE="http://yaboot.ozlabs.org/"
SRC_URI="mirror://gentoo/yaboot-static-${PV}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc ppc64"
IUSE="ibm"
DEPEND="!sys-boot/yaboot
		sys-apps/powerpc-utils"
RDEPEND="!ibm? ( sys-fs/hfsutils
				 sys-fs/hfsplusutils
				 sys-fs/mac-fdisk )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/sysfs-ofpath.patch
}

src_install() {
	# don't blow away the user's old conf file
	mv "${WORKDIR}/etc/yaboot.conf" "${WORKDIR}/etc/yaboot.conf.unconfigured" \
		|| die "mv failed"
	cp -pPR "${WORKDIR}"/* "${D}" || die "cp failed"
}
