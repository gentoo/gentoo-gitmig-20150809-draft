# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/packit/packit-0.6.0c.ebuild,v 1.1 2003/08/18 03:32:41 vapier Exp $

inherit eutils

DESCRIPTION="network auditing tool that allows you to monitor, manipulate, and inject customized IPv4 traffic"
HOMEPAGE="http://www.packetfactory.net/projects/packit/"
SRC_URI="http://www.packetfactory.net/projects/packit/downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-libs/libnet-1.1"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	econf \
		--with-libnet-includes=/usr/include/libnet-1.1 \
		--with-libnet-libraries=/usr/lib/libnet-1.1 \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	#einstall || die
	dodoc INSTALL LICENSE VERSION docs/*
}
