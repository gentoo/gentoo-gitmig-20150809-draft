# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/fwanalog/fwanalog-0.4.ebuild,v 1.1 2001/10/02 07:47:57 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Script to parse firewall logs and analyze them with Analog"
SRC_URI="http://tud.at/programm/fwanalog/${P}.tar.gz"
HOMEPAGE="http://tud.at/programm/fwanalog/"

DEPEND="" # this is just a bash script
RDEPEND="virtual/glibc
         sys-apps/bash
         sys-apps/grep
         sys-apps/gawk
         sys-apps/sed
         sys-apps/gzip
         sys-apps/diffutils
	 sys-devel/perl
         >=app-admin/analog-5.03"

src_install () {
	insinto /etc/fwanalog
	insopts -m0700 ; doins fwanalog.sh

	insopts -m0600
	doins fwanalog-dom.tab fwanalog.lng services.conf
	doins fwanalog.analog.conf fwanalog.analog.conf.local
	newins fwanalog.opts.linux24 fwanalog.opts

	dosed "s/\"zegrep\"/\"zgrep\"/" /etc/fwanalog/fwanalog.opts

	dodoc CONTRIBUTORS COPYING ChangeLog README
	docinto support ; dodoc support/*
	docinto langfiles ; dodoc langfiles/*
}
