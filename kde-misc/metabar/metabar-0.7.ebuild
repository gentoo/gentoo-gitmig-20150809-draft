# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/metabar/metabar-0.7.ebuild,v 1.9 2007/01/05 17:04:36 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="A sidebar plugin for konqueror."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=21168"
SRC_URI="mirror://sourceforge/metabar/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

DEPEND="|| ( kde-base/konqueror >=kde-base/kdebase-3.4 )
	!>=kde-base/konq-plugins-3.5.0"

RDEPEND="${DEPEND}"

need-kde 3.4

S="${WORKDIR}/${PN}"

pkg_postinst()
{
	echo
	elog "To use Metabar, run Konqueror, right-click the sidebar,"
	elog "and choose 'Add New -> Metabar'."
	echo
}
