# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-svn/thunar-svn-0.0.3-r1.ebuild,v 1.1 2009/05/01 04:18:37 darkside Exp $

inherit xfce4

DESCRIPTION="Thunar subversion plugin"
RDEPEND=">=dev-util/subversion-1.5"
DEPEND="${RDEPEND}"
ESVN_PROJECT=${PN}

KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS="AUTHORS ChangeLog NEWS README"

XFCE4_PATCHES="${FILESDIR}/${P}-subversion-1.6.patch"

xfce4_thunar_plugin
