# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-4.0.4.ebuild,v 1.1 2008/05/15 22:38:03 ingmar Exp $

EAPI="1"

KMNAME=kdesdk
inherit kde4-meta

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="${RDEPEND}
	dev-util/cvs"
