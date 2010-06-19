# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-4.3.3.ebuild,v 1.5 2010/06/19 00:56:26 abcd Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 x86"
IUSE="debug +handbook"

RDEPEND="
	dev-vcs/cvs
"
