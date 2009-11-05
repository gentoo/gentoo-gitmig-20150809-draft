# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdmthemegenerator/kdmthemegenerator-0.8.ebuild,v 1.1 2009/11/05 12:54:39 ssuominen Exp $

EAPI=2
inherit kde4-base

MY_P=KdmThemeGenerator

DESCRIPTION="A program that will generate kdm theme from your current plasma theme and wallpaper"
HOMEPAGE="http://kde-apps.org/content/show.php/Kdm+theme+generator?content=102760"
SRC_URI="http://kde-apps.org/CONTENT/content-files/102760-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=kde-base/kdm-${KDE_MINIMAL}"

S=${WORKDIR}/${MY_P}

src_install() {
	kde4-base_src_install
	exeinto /usr/share/${MY_P}
	doexe copyFromUserToSystem.sh || die
	insinto /usr/share/${MY_P}
	doins input-shadow.svg || die
}
