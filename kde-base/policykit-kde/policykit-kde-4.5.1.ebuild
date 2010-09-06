# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/policykit-kde/policykit-kde-4.5.1.ebuild,v 1.1 2010/09/06 01:58:07 tampakrap Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="PolicyKit-kde"
inherit kde4-meta

DESCRIPTION="PolicyKit integration module for KDE."
KEYWORDS=""
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	>=sys-auth/polkit-qt-0.95
"
RDEPEND="${DEPEND}
	!kde-misc/policykit-kde
"
