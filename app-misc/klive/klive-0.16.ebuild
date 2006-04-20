# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/klive/klive-0.16.ebuild,v 1.6 2006/04/20 05:13:51 flameeyes Exp $

inherit eutils

DESCRIPTION="Linux Kernel Live Usage Monitor"
HOMEPAGE="http://klive.cpushare.com/"
SRC_URI="http://klive.cpushare.com/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/python
		>=dev-python/twisted-2.0.0"
RDEPEND="sys-apps/pciutils"

S=${WORKDIR}/${PN}

pkg_setup() {
	enewuser klive -1 /bin/bash
}

src_install() {
	insinto /usr/share/${PN}
	doins client/klive.tac
	newinitd ${FILESDIR}/klive.init.d klive || die "init.d failed"
	dodoc README
}

pkg_postinst() {
	echo

	einfo "To start klive, use the init script, e.g.:"
	einfo " # /etc/init.d/klive start"
	echo

	einfo "You should add klive to your default runlevel so that it will be"
	einfo "started on on every bootup, e.g.:"
	einfo " # rc-update add klive default"
	echo

	ewarn "klive periodically submits basic information about the configuration of"
	ewarn "your running kernel to a 3rd-party server which is NOT controlled by"
	ewarn "Gentoo. This data is probably privately logged against your IP address."
	echo

	einfo "The data submitted is used to generate basic statistics which provide"
	einfo "insight as to how widely tested a particular kernel version is."
	einfo "These statistics are publically accessible at http://klive.cpushare.com"
	echo

	ewarn "If you have privacy/security concerns about the submission of this data"
	ewarn "and/or its public availability, unmerge this package now."
	echo
}

