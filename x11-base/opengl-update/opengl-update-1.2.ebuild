# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.2.ebuild,v 1.1 2002/05/29 01:13:52 azarah Exp $

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="Utility to change the OpenGL interface being used."
SRC_URI=""
HOMEPAGE="http://"

DEPEND=""


src_install() {

	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update
}

