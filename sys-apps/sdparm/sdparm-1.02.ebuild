# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sdparm/sdparm-1.02.ebuild,v 1.9 2008/05/11 09:11:18 solar Exp $

DESCRIPTION="Utility to output and modify parameters on a SCSI device, like hdparm"
HOMEPAGE="http://sg.torque.net/sg/sdparm.html"
SRC_URI="http://sg.torque.net/sg/p/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc NEWS AUTHORS ChangeLog CREDITS README notes.txt

	# These don't exist yet.  Someone wanna copy hdparm's and make them work? :)
#	newinitd ${FILESDIR}/sdparm-init-7 sdparm
#	newconfd ${FILESDIR}/sdparm-conf.d.3 sdparm
}
