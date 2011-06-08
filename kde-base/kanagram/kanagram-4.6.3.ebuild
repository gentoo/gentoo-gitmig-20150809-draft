# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kanagram/kanagram-4.6.3.ebuild,v 1.2 2011/06/08 22:52:25 tomka Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE: letter order game."
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kvtml-data)
"

KMEXTRACTONLY="
	libkdeedu/kdeeduui/
	libkdeedu/keduvocdocument/
"
