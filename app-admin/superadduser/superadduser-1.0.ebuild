# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0.ebuild,v 1.1 2002/04/09 22:39:28 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Interactive adduser script"
SRC_URI=""
HOMEPAGE=""

RDEPEND=">=sys-apps/shadow-20001016-r6"

src_install () {
	dosbin files/superadduser
	doman files/superadduser.1
}
