# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs-packages-sumo/xemacs-packages-sumo-2002.09.19.ebuild,v 1.1 2002/09/23 05:25:11 agenkin Exp $

DESCRIPTION="The SUMO bundle of ELISP packages for Xemacs"
HOMEPAGE="http://www.xemacs.org"
SRC_URI="http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/${PN/-packages/}-${PV//./-}.tar.bz2"

DEPEND=""
RDEPEND=""
S="${WORKDIR}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_install() {
	dodir /usr/lib/xemacs
	mv xemacs-packages "${D}/usr/lib/xemacs/"
}
