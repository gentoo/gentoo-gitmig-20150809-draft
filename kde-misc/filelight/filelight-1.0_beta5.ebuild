# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight/filelight-1.0_beta5.ebuild,v 1.1 2004/11/21 22:19:34 centic Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Filelight is a tool to display where the space is used on the harddisk"
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/filelight/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~hppa ~sparc"
IUSE=""

need-kde 3.2

src_compile() {
	# Unconditionally use -fPIC for libs (#55238)
	sed -e '/^CPPFLAGS/s/$/ -fPIC/' -i src/part/radialmap/Makefile.in

	kde_src_compile all
}
