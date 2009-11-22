# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okteta/okteta-4.3.3-r1.ebuild,v 1.1 2009/11/22 15:59:24 scarabeus Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE hexeditor"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PV}-detect_changes_correctly.patch"
	"${FILESDIR}/${PV}-fix_inverse_save_logic.patch"
)
