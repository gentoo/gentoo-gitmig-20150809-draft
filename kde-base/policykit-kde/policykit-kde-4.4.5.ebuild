# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/policykit-kde/policykit-kde-4.4.5.ebuild,v 1.2 2010/08/09 17:33:42 scarabeus Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="PolicyKit-kde"
inherit kde4-meta

DESCRIPTION="PolicyKit integration module for KDE."
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	>=sys-auth/policykit-qt-0.9.3
"
RDEPEND="${DEPEND}
	!kde-misc/policykit-kde
"
