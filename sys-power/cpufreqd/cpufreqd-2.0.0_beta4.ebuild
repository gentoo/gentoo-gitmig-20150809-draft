# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/cpufreqd-2.0.0_beta4.ebuild,v 1.1 2005/08/26 12:06:06 brix Exp $

inherit flag-o-matic linux-info

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="CPU Frequency Daemon"
HOMEPAGE="http://cpufreqd.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND="sys-power/cpufrequtils"
RDEPEND="${DEPEND}"

CONFIG_CHECK="CPU_FREQ"
ERROR_CPU_FREQ="${P} requires support for CPU Frequency scaling (CONFIG_CPU_FREQ)"

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO

	newinitd ${FILESDIR}/${P}-init.d ${PN}
}

pkg_postinst() {
	einfo
	einfo "Significant changes have happened since the 1.x releases, including"
	einfo "changes in the configuration file format."
	einfo
	einfo "Make sure you update your /etc/cpufreqd.conf file before starting"
	einfo "${PN}. You can use 'etc-update' to accomplish this:"
	einfo
    einfo "  # etc-update"
	einfo
}
