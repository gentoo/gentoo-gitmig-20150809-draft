# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/feedbackd-agent/feedbackd-agent-0.3.1.ebuild,v 1.1 2004/06/08 23:34:40 tantive Exp $

inherit eutils

DESCRIPTION="Feedbackd is a client/server system that provides dynamic feedback of server
load in a Linux Virtual Server (LVS)-based cluster. Monitor plugins are used to
measure the health of each server, allowing a flexible way to report load back
to the load balancer. It also facilitates the addition and removal of servers
from the cluster.

This is the agent process for feedbackd, which is run on the real server."

HOMEPAGE="http://www.redfishsoftware.com.au/projects/feedbackd/"
LICENSE="GPL-2"
DEPEND="virtual/glibc
	>=dev-libs/libxml2
	>=dev-lang/perl"

SRC_URI="http://aleron.dl.sourceforge.net/sourceforge/feedbackd/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}/${P}"

src_compile() {

	epatch ${FILESDIR}/compile-gnu-source.patch

	CFLAGS="${CFLAGS/-O?/} -O2" \
	econf \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--with-xml-config=/usr/bin/xml2-config \
		--with-perl=/usr/bin/perl \
		|| die "bad ./configure"

	cd "${S}"
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README || die
}
