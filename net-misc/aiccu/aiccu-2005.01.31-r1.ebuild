# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aiccu/aiccu-2005.01.31-r1.ebuild,v 1.1 2006/02/05 09:24:07 gmsoft Exp $

inherit eutils

DESCRIPTION="AICCU Client to configure an IPv6 tunnel to SixXS."
HOMEPAGE="http://www.sixxs.net/tools/aiccu"
SRC_URI="http://www.sixxs.net/archive/sixxs/${PN}/unix/${PN}_${PV}.tar.gz"

LICENSE="AICCU"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~hppa"
IUSE=""
DEPEND="sys-apps/iproute2"
S=${WORKDIR}/${PN}

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/patch_aiccu_ticservpar_${PV}
	sed -e 's/ip -6 ro /ip -6 route /' -i common/aiccu_linux.c
}

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS}" || die "Build Failed"
}

src_install() {
	dosbin unix-console/aiccu
	insopts -m 600
	insinto /etc
	doins doc/aiccu.conf
	dodoc doc/{HOWTO,LICENSE,README,changelog}
	newinitd doc/aiccu.init.gentoo aiccu
}

pkg_postinst() {
	einfo "The aiccu ebuild installs an init script named 'aiccu'"
	einfo "To add support for a SixXS connection at startup, do"
	einfo "edit your /etc/aiccu.conf and do"
	einfo "# rc-update add aiccu default"
}
