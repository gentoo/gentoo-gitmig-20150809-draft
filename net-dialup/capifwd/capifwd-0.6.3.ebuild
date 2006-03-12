# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capifwd/capifwd-0.6.3.ebuild,v 1.4 2006/03/12 09:23:20 mrness Exp $

inherit eutils

DESCRIPTION="A daemon forwarding CAPI messages to capi20proxy clients"
HOMEPAGE="http://capi20proxy.sourceforge.net/"
SRC_URI="mirror://sourceforge/capi20proxy/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="net-dialup/capi4k-utils"

S="${WORKDIR}/linux-server"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}.patch"

	#Replace obsolete sys_errlist with strerror
	sed -i -e 's:sys_errlist *\[ *errno *\]:strerror(errno):' \
		src/capifwd.c src/capi/waitforsignal.c src/auth/auth.c || \
		die "failed to replace sys_errlist"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog README

	# install init-script
	newinitd "${FILESDIR}/capifwd.init" capifwd
	newconfd "${FILESDIR}/capifwd.conf" capifwd
}
