# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs-packages-sumo/xemacs-packages-sumo-2002.07.20-r1.ebuild,v 1.5 2002/12/09 04:17:41 manson Exp $

DESCRIPTION="The SUMO bundle of ELISP packages for Xemacs"
HOMEPAGE="http://www.xemacs.org"
SRC_URI="http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/${PN/-packages/}-${PV//./-}.tar.bz2
	http://ftp.xemacs.org/pub/packages/ps-print-1.07-pkg.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="sys-apps/tar
	sys-apps/gzip
	sys-apps/bzip2"
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	cd ${WORKDIR}
	unpack "${PN/-packages/}-${PV//./-}.tar.bz2"
	cd xemacs-packages
	unpack ps-print-1.07-pkg.tar.gz
}

src_install() {
	dodir /usr/lib/xemacs
	mv xemacs-packages "${D}/usr/lib/xemacs/"
}
