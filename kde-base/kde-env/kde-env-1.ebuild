# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-1.ebuild,v 1.1 2002/08/12 19:41:35 danarmak Exp $

DESCRIPTION="Sets up some env.d files for kde"
SRC_URI=""
DEPEND=""
KEYWORDS="*" # works everywhere - nothing to compile, no deps
LICENSE="GPL-2" # like the ebuild itself
SLOT="0"

src_unpack() { true; }
src_compile() { true; }

src_install() {

    dodir /etc/env.d
    echo "KDEDIRS=/usr" > ${D}/etc/env.d/10kde-env

}
