# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config-wrapper/java-config-wrapper-0.14.ebuild,v 1.2 2007/12/16 15:09:54 maekke Exp $

DESCRIPTION="Wrapper for java-config"
HOMEPAGE="http://www.gentoo.org/proj/en/java"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="!<dev-java/java-config-1.3"
RDEPEND="app-portage/portage-utils"

src_install() {
	dobin src/shell/* || die
	dodoc ChangeLog AUTHORS || die
}
