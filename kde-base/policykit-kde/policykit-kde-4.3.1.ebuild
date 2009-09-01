# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/policykit-kde/policykit-kde-4.3.1.ebuild,v 1.1 2009/09/01 16:25:46 tampakrap Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="PolicyKit-kde"
inherit kde4-meta

DESCRIPTION="PolicyKit integration module for KDE."
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	sys-auth/policykit-qt
"
RDEPEND="${DEPEND}
	!kde-misc/policykit-kde
"
