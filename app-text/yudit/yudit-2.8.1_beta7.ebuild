# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yudit/yudit-2.8.1_beta7.ebuild,v 1.1 2006/05/08 15:56:22 squinky86 Exp $

inherit versionator

MY_P="${PN}-$(replace_version_separator 3 '.')"
S=${WORKDIR}/${MY_P}

DESCRIPTION="free (Y)unicode text editor for all unices"
SRC_URI="http://yudit.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.yudit.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="|| ( x11-libs/libX11 virtual/x11 )
	>=sys-devel/gettext-0.10"

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
