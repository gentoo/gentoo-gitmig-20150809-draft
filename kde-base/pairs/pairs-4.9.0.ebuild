# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/pairs/pairs-4.9.0.ebuild,v 1.1 2012/08/01 22:16:53 johu Exp $

EAPI=4

KDE_HANDBOOK="never"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE memory and pairs game"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"
