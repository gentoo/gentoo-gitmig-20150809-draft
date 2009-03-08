# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystemlog/ksystemlog-4.2.1.ebuild,v 1.2 2009/03/08 14:03:59 scarabeus Exp $

EAPI="2"

KMNAME="kdeadmin"
KMMODULE="ksystemlog"
inherit kde4-meta

DESCRIPTION="KSystemLog is a system log viewer for KDE."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${RDEPEND}"
