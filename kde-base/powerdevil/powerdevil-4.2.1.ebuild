# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/powerdevil/powerdevil-4.2.1.ebuild,v 1.1 2009/03/04 22:53:03 alexxy Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="!sys-power/powerdevil
	kde-base/libkworkspace:${SLOT}
	kde-base/solid:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="krunner
	ksmserver/org.kde.KSMServerInterface.xml"
