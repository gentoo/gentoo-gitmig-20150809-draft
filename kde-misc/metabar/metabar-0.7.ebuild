# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/metabar/metabar-0.7.ebuild,v 1.3 2005/04/05 22:23:15 greg_g Exp $

inherit kde

DESCRIPTION="A sidebar plugin for konqueror."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=21168"
SRC_URI="mirror://sourceforge/metabar/${P}.tar.gz"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="|| ( kde-base/konqueror >=kde-base/kdebase-3.4 )"

need-kde 3.4

S="${WORKDIR}/${PN}"

pkg_postinst()
{
	echo
	einfo "To use Metabar, run Konqueror, right-click the sidebar,"
	einfo "and choose 'Add New -> Metabar'."
	echo
}
