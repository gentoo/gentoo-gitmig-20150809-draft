# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/haveged/haveged-1.1.ebuild,v 1.5 2012/01/26 23:26:58 darkside Exp $

EAPI=4
DESCRIPTION="A simple entropy daemon using the HAVEGE algorithm"
HOMEPAGE="http://www.issihosts.com/haveged/"
SRC_URI="http://www.issihosts.com/haveged/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 -arm x86"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

src_configure() {
	econf --bindir=/usr/sbin --enable-nistest
}

src_install() {
	default
	# This is a RedHat init script
	rm -rf "${D}"/etc/init.d/haveged
	# Install gentoo ones instead
	newinitd "${FILESDIR}"/haveged-init.d haveged
	newconfd "${FILESDIR}"/haveged-conf.d haveged
}
