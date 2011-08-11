# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/eventlist/eventlist-0.4.95.ebuild,v 1.1 2011/08/11 21:03:40 dilfridge Exp $

EAPI=4

MY_P="plasmoid-${P}"
KDE_LINGUAS="cs de es et fr it ja nds nl pt pt_BR ru sk sv uk"
inherit kde4-base

DESCRIPTION="Plasmoid showing the events from Akonadi resources"
HOMEPAGE="http://kde-look.org/content/show.php/Eventlist?content=107779"
SRC_URI="http://kde-look.org/CONTENT/content-files/107779-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep akonadi)
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}
