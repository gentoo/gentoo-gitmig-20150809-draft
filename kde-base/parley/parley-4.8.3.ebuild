# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/parley/parley-4.8.3.ebuild,v 1.1 2012/05/03 20:07:42 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Educational: vocabulary trainer"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +plasma"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"

KMEXTRACTONLY="
	libkdeedu/keduvocdocument
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with plasma)
	)

	kde4-base_src_configure
}
