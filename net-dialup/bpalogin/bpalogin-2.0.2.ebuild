# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/bpalogin/bpalogin-2.0.2.ebuild,v 1.7 2006/12/08 01:34:43 flameeyes Exp $

DESCRIPTION="A replacement for the Telstra supplied client for connecting and using Telstra's Big Pond Advance powered by Cable."
SRC_URI="http://bpalogin.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://bpalogin.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~x86-fbsd"
IUSE=""

src_install () {
	dosbin bpalogin
	insinto /etc
	insopts -m600
	doins bpalogin.conf
	newinitd "${FILESDIR}/bpalogin.rc" bpalogin
}
