# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-vmailmgr/qmail-vmailmgr-0.0.1-r1.ebuild,v 1.16 2006/02/20 21:50:13 hansmi Exp $

S=${WORKDIR}
DESCRIPTION="qmail with vmailmgr - a fully-fledged virtual domains hosting environment"
HOMEPAGE="http://vmailmgr.org"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
IUSE=""

RDEPEND="virtual/qmail
>=net-mail/vmailmgr-0.96.9-r1
>=net-mail/cvm-vmailmgr-0.3
>=net-mail/mailfront-0.74"
