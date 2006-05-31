# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mrtg-ping-probe/mrtg-ping-probe-2.2.0.ebuild,v 1.1 2006/05/31 07:32:36 jokey Exp $

DESCRIPTION="Addon mrtg contrib for stats ping/loss packets"
SRC_URI="ftp://ftp.pwo.de/pub/pwo/mrtg/mrtg-ping-probe/${P}.tar.gz"
HOMEPAGE="ftp://ftp.pwo.de/pub/pwo/mrtg/mrtg-ping-probe/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-analyzer/mrtg"

src_unpack() {
		unpack ${A} || die
		cd ${S} || die
		sed -i -e 's:#!/usr/local/bin/perl -w:#!/usr/bin/perl -w:' check-ping-fmt
		#sed -i -e 's:#!/bin/ksh:#!/bin/sh:' mrtg-ping-cfg
		#sed -i -e 's:head -10:head -n 10:' mrtg-ping-cfg
		#sed -i -e 's:PING_PROBE=/usr/local/httpd/mrtg/mrtg-ping-probe:PING_PROBE=/usr/bin/mrtg-ping-probe:' mrtg-ping-cfg
		sed -i -e 's:#!/bin/perl:#!/usr/bin/perl:' mrtg-ping-probe
}

src_compile() {
		emake || die
}

src_install () {
		dodoc ChangeLog INSTALL NEWS README TODO mrtg.cfg-ping
		doman mrtg-ping-probe.1
		dobin check-ping-fmt mrtg-ping-probe ${FILESDIR}/mrtg-ping-cfg
}

