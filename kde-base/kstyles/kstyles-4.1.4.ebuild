# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstyles/kstyles-4.1.4.ebuild,v 1.1 2009/01/13 22:54:17 alexxy Exp $

EAPI="2"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="KDE: A set of different KDE styles."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=kde-base/qimageblitz-0.0.4"
RDEPEND="${DEPEND}"
