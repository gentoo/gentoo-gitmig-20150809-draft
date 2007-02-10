# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/bpalogin/bpalogin-2.0.2.ebuild,v 1.9 2007/02/10 04:04:50 beandog Exp $

DESCRIPTION="A replacement for the Telstra supplied client for connecting and using Telstra's Big Pond Advance powered by Cable."
SRC_URI="http://bpalogin.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://bpalogin.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

src_install () {
	dosbin bpalogin
	insinto /etc
	insopts -m600
	doins bpalogin.conf
	newinitd "${FILESDIR}/bpalogin.rc" bpalogin
}
