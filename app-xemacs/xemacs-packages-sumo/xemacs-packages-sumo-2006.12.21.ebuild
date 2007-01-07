# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-packages-sumo/xemacs-packages-sumo-2006.12.21.ebuild,v 1.1 2007/01/07 10:32:30 graaff Exp $

DESCRIPTION="The SUMO bundle of ELISP packages for Xemacs"
HOMEPAGE="http://www.xemacs.org"
SRC_URI="http://ftp.xemacs.org/pub/packages/xemacs-sumo-${PV//./-}.tar.bz2
	http://ftp.xemacs.org/pub/packages/oldsumo/xemacs-sumo-${PV//./-}.tar.bz2
	mule? ( http://ftp.xemacs.org/pub/packages/xemacs-mule-sumo-${PV//./-}.tar.bz2
		http://ftp.xemacs.org/pub/packages/oldsumo/xemacs-mule-sumo-${PV//./-}.tar.bz2 )"

DEPEND="app-arch/tar app-arch/bzip2"
RDEPEND="virtual/xemacs"
S="${WORKDIR}"

IUSE="mule"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

src_compile() {
	true
}

src_install() {
	dodir /usr/lib/xemacs
	local DEST="${D}/usr/lib/xemacs/"
	mv xemacs-packages "${DEST}" || die
	if use mule
	then
		mv mule-packages "${DEST}" || die
	fi
}
