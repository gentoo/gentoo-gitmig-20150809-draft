# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/policykit-kde/policykit-kde-4.4.4.ebuild,v 1.2 2010/06/21 15:52:56 scarabeus Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="PolicyKit-kde"
inherit kde4-meta

DESCRIPTION="PolicyKit integration module for KDE."
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	>=sys-auth/policykit-qt-0.9.3
"
RDEPEND="${DEPEND}
	!kde-misc/policykit-kde
"
