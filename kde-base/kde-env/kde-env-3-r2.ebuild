# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-3-r2.ebuild,v 1.12 2004/01/29 03:10:50 agriffis Exp $

DESCRIPTION="Sets up some env.d files for kde"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"
DEPEND=""
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64" # works everywhere - nothing to compile, no deps
# needs the new portage to process the CONFIG_PROTECT values correctly
RDEPEND=">=sys-apps/portage-2.0.36"
DEPEND=""
LICENSE="GPL-2" # like the ebuild itself
SLOT="0"

src_unpack() { true; }
src_compile() { true; }

src_install() {

	dodir /etc/env.d
	echo "KDEDIRS=/usr
CONFIG_PROTECT=/usr/share/config" > ${D}/etc/env.d/99kde-env

}
