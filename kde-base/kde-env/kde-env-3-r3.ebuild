# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-3-r3.ebuild,v 1.1 2004/08/25 19:03:54 caleb Exp $

DESCRIPTION="Sets up some env.d files for kde"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2" # like the ebuild itself
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips ~ppc64" # works everywhere - nothing to compile, no deps
IUSE=""

# needs the new portage to process the CONFIG_PROTECT values correctly
DEPEND=""
RDEPEND=">=sys-apps/portage-2.0.36"

src_unpack() { true; }
src_compile() { true; }

src_install() {
	dodir /etc/env.d
	echo "KDEDIRS=/usr
CONFIG_PROTECT=/usr/share/config
KDE_MALLOC=1
#KDE_IS_PRELINKED=1" > ${D}/etc/env.d/99kde-env
}
