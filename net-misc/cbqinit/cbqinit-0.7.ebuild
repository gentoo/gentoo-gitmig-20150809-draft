# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cbqinit/cbqinit-0.7.ebuild,v 1.5 2003/05/15 15:58:33 phosphan Exp $

S=${WORKDIR}
DESCRIPTION="Sets up class-based queue traffic control (QoS) with iproute2"
HOMEPAGE="http://www.sourceforge.net/projects/cbqinit"
SRC_URI="mirror://sourceforge/cbqinit/cbq.init-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

DEPEND=">=sys-apps/sed-4.0.5"

RDEPEND="sys-apps/iproute"

src_unpack() {
	cp ${DISTDIR}/cbq.init-v${PV} ${S}
}

src_compile() {
	sed -i \
		-e 's|^CBQ_PATH=.*|CBQ_PATH=/etc/cbqinit|' \
		-e 's|CBQ_CACHE=.*|CBQ_CACHE=/var/cache/cbqinit|' \
		cbq.init-v${PV}
}

src_install() {
	exeinto /usr/sbin
	newexe cbq.init-v${PV} cbqinit

	exeinto /etc/init.d
	newexe ${FILESDIR}/rc_cbqinit cbqinit

	insinto /etc/cbqinit/sample
	newins ${FILESDIR}/cbq-1280.My_first_shaper.sample cbq-1280.My_first_shaper

	dodoc cbqinit
}

pkg_postinst() {
	einfo 'Run "rc-update add cbqinit default" to run cbqinit at startup.'
}
