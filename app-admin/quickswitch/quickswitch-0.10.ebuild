# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/quickswitch/quickswitch-0.10.ebuild,v 1.1 2001/12/07 18:00:05 jerrya Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Utility to switch network profiles on the fly"
SRC_URI="http://prdownloads.sourceforge.net/quickswitch/${P}.tar.gz"

HOMEPAGE="http://edgesolutions.ca/"

DEPEND=">=sys-devel/perl-5.6.0"


src_install () {
	dobin switchto
	dosed "s:/etc/switch.conf:/etc/quickswitch/switch.conf:" /usr/bin/switchto
	dosed "s:/etc/switchto.last:/etc/quickswitch/switchto.last:" /usr/bin/switchto

	exeinto /etc/init.d
	newexe ${FILESDIR}/net-switchto.rc6 net-switchto

	dodir /etc/quickswitch
	insinto /etc/quickswitch
	newins switch.conf switch.conf.sample

	dodoc README LICENSE
}
