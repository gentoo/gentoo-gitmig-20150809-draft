# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-3-r2.ebuild,v 1.1 2002/09/06 11:57:38 danarmak Exp $

DESCRIPTION="Sets up some env.d files for kde"
SRC_URI=""
DEPEND=""
KEYWORDS="x86" # works everywhere - nothing to compile, no deps
# however, this revision is only enabled for x86 for now beacuse it needs the new portage
# to process the CONFIG_PROTECT value correctly, and some archs use older portage versions
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
