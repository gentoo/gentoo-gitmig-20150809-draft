# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/packit/packit-0.7.ebuild,v 1.3 2004/04/12 02:07:36 vapier Exp $

inherit eutils

DESCRIPTION="network auditing tool that allows you to monitor, manipulate, and inject customized IPv4 traffic"
HOMEPAGE="http://www.packetfactory.net/projects/packit/"
SRC_URI="http://www.packetfactory.net/projects/packit/downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-libs/libnet-1.1.0-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	has_version '>=net-libs/libpcap-0.8.1' \
		&& sed -i 's!^#include <net/bpf.h>$!#include <pcap-bpf.h>!' \
		src/{globals,main}.h
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc INSTALL LICENSE VERSION docs/*
}
