# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/policykit-kde/policykit-kde-4.3.2.ebuild,v 1.2 2009/10/09 17:54:35 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="PolicyKit-kde"
inherit kde4-meta

DESCRIPTION="PolicyKit integration module for KDE."
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	sys-auth/policykit-qt
"
RDEPEND="${DEPEND}
	!kde-misc/policykit-kde
"
