# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs-packages-sumo/xemacs-packages-sumo-2002.09.19-r1.ebuild,v 1.2 2002/12/25 22:44:41 agenkin Exp $

DESCRIPTION="The SUMO bundle of ELISP packages for Xemacs"
HOMEPAGE="http://www.xemacs.org"
SRC_URI="http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/xemacs-sumo-${PV//./-}.tar.bz2
	mule? ( http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/xemacs-mule-sumo-${PV//./-}.tar.bz2 )"

DEPEND="sys-apps/tar sys-apps/bzip2"
RDEPEND=""
S="${WORKDIR}"

IUSE="mule"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

src_compile() {
	true
}

src_install() {
	dodir /usr/lib/xemacs
	local DEST="${D}/usr/lib/xemacs/"
	mv xemacs-packages "${DEST}" || die
	if [ "`use mule`" ]
	then
		mv mule-packages "${DEST}" || die
	fi
}
