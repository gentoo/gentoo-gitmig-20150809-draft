# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}
DESCRIPTION="qmail with vmailmgr - a fullfletched virtual domains hosting enviroment"
HOMEPAGE="http://vmailmgr.org"

RDEPEND=">=net-mail/qmail-1.03-r7
>=net-mail/vmailmgr-0.96.9-r1
>=net-mail/cvm-vmailmgr-0.3
>=net-mail/mailfront-0.74"
