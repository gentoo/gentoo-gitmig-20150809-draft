# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-3-r1.ebuild,v 1.12 2004/07/14 16:03:35 agriffis Exp $

DESCRIPTION="Sets up some env.d files for kde"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"
DEPEND=""
KEYWORDS="x86 ppc sparc" # works everywhere - nothing to compile, no deps
IUSE=""
LICENSE="GPL-2" # like the ebuild itself
SLOT="0"

src_unpack() { true; }
src_compile() { true; }

src_install() {

	dodir /etc/env.d
	echo "KDEDIRS=/usr" > ${D}/etc/env.d/99kde-env

}
