# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/klive/klive-0.28.ebuild,v 1.3 2008/05/13 15:59:27 jer Exp $

inherit eutils

DESCRIPTION="Linux Kernel Live Usage Monitor"
HOMEPAGE="http://klive.cpushare.com/"
SRC_URI="http://klive.cpushare.com/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~sparc ~x86"
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
	newinitd "${FILESDIR}"/klive.init.d klive || die "init.d failed"
	dodoc README
}

pkg_postinst() {
	echo

	elog "To start klive, use the init script, e.g.:"
	elog " # /etc/init.d/klive start"
	echo

	elog "You should add klive to your default runlevel so that it will be"
	elog "started on on every bootup, e.g.:"
	elog " # rc-update add klive default"
	echo

	ewarn "klive periodically submits basic information about the configuration of"
	ewarn "your running kernel to a 3rd-party server which is NOT controlled by"
	ewarn "Gentoo. This data is probably privately logged against your IP address."
	ewarn

	ewarn "The data submitted is used to generate basic statistics which provide"
	ewarn "insight as to how widely tested a particular kernel version is."
	ewarn "These statistics are publically accessible at http://klive.cpushare.com"
	ewarn

	ewarn "If you have privacy/security concerns about the submission of this data"
	ewarn "and/or its public availability, unmerge this package now."
	echo
}
