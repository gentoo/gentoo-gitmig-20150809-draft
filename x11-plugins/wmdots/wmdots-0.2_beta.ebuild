# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdots/wmdots-0.2_beta.ebuild,v 1.5 2003/09/06 05:56:25 msterret Exp $

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
