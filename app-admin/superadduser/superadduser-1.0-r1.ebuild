# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0-r1.ebuild,v 1.1 2002/04/17 02:28:51 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Interactive adduser script"
SRC_URI=""
HOMEPAGE=""

RDEPEND="sys-apps/shadow"

src_install () {
	dosbin ${FILESDIR}/superadduser
	doman ${FILESDIR}/superadduser.8
}
