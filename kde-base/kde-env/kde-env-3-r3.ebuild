# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-3-r3.ebuild,v 1.10 2005/04/08 14:44:15 corsair Exp $

DESCRIPTION="Sets up some env.d files for KDE"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

# needs the new portage to process the CONFIG_PROTECT values correctly
DEPEND=""
RDEPEND=">=sys-apps/portage-2.0.36"

S=${WORKDIR}

src_install() {
	dodir /etc/env.d
	cat << EOF > ${D}/etc/env.d/99kde-env
KDEDIRS=/usr
CONFIG_PROTECT=/usr/share/config
KDE_MALLOC=1
#KDE_IS_PRELINKED=1
EOF
}
