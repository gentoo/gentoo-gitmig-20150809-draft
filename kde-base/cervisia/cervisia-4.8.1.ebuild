# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-4.8.1.ebuild,v 1.2 2012/04/04 16:46:56 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	dev-vcs/cvs
"
