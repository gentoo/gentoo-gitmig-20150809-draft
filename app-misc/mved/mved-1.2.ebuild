# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mved/mved-1.2.ebuild,v 1.1 2005/11/12 12:40:49 avenj Exp $

DESCRIPTION="An editor-focused multiple file move utility."
HOMEPAGE="http://guerila.com"
SRC_URI="http://guerila.com/downloads/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"

IUSE=""
DEPEND=""
RDEPEND="virtual/python"

src_install() {
	dodoc README
	dobin mved
}
