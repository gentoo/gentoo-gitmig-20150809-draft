# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-svn/thunar-svn-0.0.3.ebuild,v 1.2 2009/03/16 15:40:35 angelos Exp $

inherit xfce4

DESCRIPTION="Thunar subversion plugin"
RDEPEND=">=dev-util/subversion-1.5"
DEPEND="${RDEPEND}"
ESVN_PROJECT=${PN}

KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS="AUTHORS ChangeLog NEWS README"

xfce4_thunar_plugin
