# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/jaffm/jaffm-1.0.ebuild,v 1.1 2003/12/26 00:48:20 pyrania Exp $

DESCRIPTION="Just A Fucking File Manager"
HOMEPAGE="http://jaffm.binary.is/"

SRC_URI="http://www.binary.is/download/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4"

S=${WORKDIR}/${P}

src_install() {
	mkdir -p ${D}/usr/bin
	cp ${S}/jaffm ${D}/usr/bin/jaffm
}
