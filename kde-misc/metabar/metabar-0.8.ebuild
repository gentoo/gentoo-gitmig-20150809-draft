# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/metabar/metabar-0.8.ebuild,v 1.3 2006/02/21 18:25:05 carlo Exp $

inherit kde

DESCRIPTION="A sidebar plugin for konqueror."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=21168"
SRC_URI="mirror://sourceforge/metabar/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/konqueror >=kde-base/kdebase-3.3 )
	!>=kde-base/konq-plugins-3.5.0"

need-kde 3.3

S="${WORKDIR}/${PN}"

pkg_postinst()
{
	echo
	einfo "To use Metabar, run Konqueror, right-click the sidebar,"
	einfo "and choose 'Add New -> Metabar'."
	echo
}
