# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okteta/okteta-4.7.4.ebuild,v 1.1 2011/12/11 18:52:23 alexxy Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="KDE hexeditor"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
