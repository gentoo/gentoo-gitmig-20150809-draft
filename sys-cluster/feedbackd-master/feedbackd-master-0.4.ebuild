# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/feedbackd-master/feedbackd-master-0.4.ebuild,v 1.4 2005/03/08 02:49:52 xmerlin Exp $

inherit eutils

DESCRIPTION="Feedbackd is a client/server system that provides dynamic feedback of server
load in a Linux Virtual Server (LVS)-based cluster. Monitor plugins are used to
measure the health of each server, allowing a flexible way to report load back
to the load balancer. It also facilitates the addition and removal of servers
from the cluster.

This is the master process for feedbackd, which is run on the LVS director."

HOMEPAGE="http://ozlabs.org/~jk/projects/feedbackd/"
LICENSE="GPL-2"
DEPEND="virtual/libc
	dev-libs/libxml2
	>=sys-cluster/ipvsadm-1.24
	dev-lang/perl"

SRC_URI="mirror://sourceforge/feedbackd/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${P}"

src_compile() {
	einfo "Note: feedbackd-master needs a kernel with ipvs support and with ipvs enabled"

	econf \
		--sysconfdir=/etc \
		--localstatedir=/var \
		|| die "bad ./configure"

	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog NEWS README
}
