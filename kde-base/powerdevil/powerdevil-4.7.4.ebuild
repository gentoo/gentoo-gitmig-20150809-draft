# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/powerdevil/powerdevil-4.7.4.ebuild,v 1.3 2012/01/16 23:47:04 ago Exp $

EAPI=4

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
LICENSE="GPL-2"

KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +pm-utils"

DEPEND="
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)
"
RDEPEND="${DEPEND}
	pm-utils? ( sys-power/pm-utils )
"

KMEXTRACTONLY="
	krunner/
	ksmserver/org.kde.KSMServerInterface.xml
"
