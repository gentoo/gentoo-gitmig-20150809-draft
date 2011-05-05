# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm-gtk-config/kcm-gtk-config-1.3.ebuild,v 1.1 2011/05/05 13:26:55 scarabeus Exp $

EAPI=4

KDE_MINIMAL="4.6"
KDE_LINGUAS_DIR=translations
KDE_LINGUAS="ca es fr gl id it"
MY_P=${P/kcm/chakra}
inherit kde4-base

DESCRIPTION="KCM for set the look&feel of your Gtk apps using the KDE systemsettings."
HOMEPAGE="http://kde-apps.org/content/show.php?content=137496"
SRC_URI="http://chakra-project.org/sources/gtk-integration/${MY_P}.tar.gz"

LICENSE="GPL-3"

KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

COMMON_DEPEND="$(add_kdebase_dep kdelibs)"
DEPEND="${COMMON_DEPEND}
	dev-util/automoc
"
RDEPEND="${COMMON_DEPEND}
	!kde-misc/kcm_gtk
	$(add_kdebase_dep kcmshell)
"

S=${WORKDIR}/${MY_P}
