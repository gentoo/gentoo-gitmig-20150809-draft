# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm-ufw/kcm-ufw-0.4.1.ebuild,v 1.1 2012/01/08 15:26:07 thev00d00 Exp $

EAPI=4

KDE_MINIMAL="4.5"
KDE_LINGUAS="en es fr lt"
inherit kde4-base

MY_P="${P/-/_}"

DESCRIPTION="KCM module to control the Uncomplicated Firewall"
HOMEPAGE="http://kde-apps.org/content/show.php?content=137789"
SRC_URI="http://craigd.wikispaces.com/file/view/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="$(add_kdebase_dep kdelibs)
	net-firewall/ufw
	sys-auth/polkit-kde-agent
"
DEPEND="${COMMON_DEPEND}
	dev-util/automoc
"
RDEPEND="${COMMON_DEPEND}
	$(add_kdebase_dep kcmshell)
"

S="${WORKDIR}/${MY_P}"
