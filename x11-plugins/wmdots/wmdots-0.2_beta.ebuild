# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdots/wmdots-0.2_beta.ebuild,v 1.3 2003/06/12 22:27:42 msterret Exp $

MY_P=wmdots-0.2beta
S=${WORKDIR}/${PN}
DESCRIPTION="Multi shape 3d rotating dots"
SRC_URI="http://dockapps.org/download.php/id/153/${MY_P}.tar.gz"
HOMEPAGE="http://dockapps.org/file.php/id/116"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

IUSE=""

DEPEND="virtual/x11"


src_compile() {

	emake || die
	
}

src_install () {

	dobin ${S}/wmdots
}
