# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-vmailmgr/qmail-vmailmgr-0.0.1-r1.ebuild,v 1.13 2004/07/15 01:59:20 agriffis Exp $

S=${WORKDIR}
DESCRIPTION="qmail with vmailmgr - a fullfletched virtual domains hosting enviroment"
HOMEPAGE="http://vmailmgr.org"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
IUSE=""

RDEPEND=">=mail-mta/qmail-1.03-r7
>=net-mail/vmailmgr-0.96.9-r1
>=net-mail/cvm-vmailmgr-0.3
>=net-mail/mailfront-0.74"
