# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/powerdevil/powerdevil-4.5.1.ebuild,v 1.1 2010/09/06 01:58:52 tampakrap Exp $

EAPI="3"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
LICENSE="GPL-2"

KEYWORDS=""
IUSE="debug +pm-utils"

COMMONDEPEND="
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)
	!aqua? ( x11-libs/libXScrnSaver )
"
DEPEND="${COMMONDEPEND}
	!aqua? ( x11-proto/scrnsaverproto )
"
RDEPEND="${COMMONDEPEND}
	!sys-power/powerdevil
	pm-utils? ( sys-power/pm-utils )
"

KMEXTRACTONLY="
	krunner/
	ksmserver/org.kde.KSMServerInterface.xml
"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.3-fix-sleep-205453.patch"
)
