# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/fax4cups/fax4cups-1.23.ebuild,v 1.6 2004/05/05 23:14:58 lanius Exp $

DESCRIPTION="efax/hylafax backend for CUPS"

HOMEPAGE="http://vigna.dsi.unimi.it/fax4CUPS/"
SRC_URI="http://vigna.dsi.unimi.it/fax4CUPS/fax4CUPS-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="net-print/cups
	|| ( net-misc/hylafax net-misc/efax net-dialup/mgetty )
	app-admin/sudo"

S=${WORKDIR}/fax4CUPS-${PV}


src_install() {

	doman fax4CUPS.1

	# Backends
	exeinto /usr/lib/cups/backend
	doexe efax hylafax

	# PPD's
	insinto /usr/share/cups/model
	doins efax.ppd hylafax.ppd
}
