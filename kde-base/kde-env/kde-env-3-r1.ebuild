# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-3-r1.ebuild,v 1.13 2004/08/26 01:03:41 vapier Exp $

DESCRIPTION="Sets up some env.d files for KDE"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_install() {
	dodir /etc/env.d
	echo "KDEDIRS=/usr" > ${D}/etc/env.d/99kde-env
}
