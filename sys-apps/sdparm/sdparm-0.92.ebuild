# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sdparm/sdparm-0.92.ebuild,v 1.3 2005/07/29 04:39:39 kumba Exp $

DESCRIPTION="Utility to output and modify parameters on a SCSI device, like hdparm"
HOMEPAGE="http://sg.torque.net/sg/sdparm.html"
SRC_URI="http://sg.torque.net/sg/p/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc mips ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die "configure error"
	emake || die "compile error"
}

src_install() {
	einstall

	# These don't exist yet.  Someone wanna copy hdparm's and make them work? :)
#	newinitd ${FILESDIR}/sdparm-init-7 sdparm
#	newconfd ${FILESDIR}/sdparm-conf.d.3 sdparm

	doman sdparm.8

	# NEWS is 0-bytes.  Skip until `dodoc' handles those.
	dodoc AUTHORS ChangeLog COPYING CREDITS README
}
