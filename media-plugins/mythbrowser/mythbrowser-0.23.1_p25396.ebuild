# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythbrowser/mythbrowser-0.23.1_p25396.ebuild,v 1.2 2011/07/08 15:16:16 cardoe Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="Web browser module for MythTV."
IUSE=""
KEYWORDS="amd64 ~ppc x86"

RDEPEND=">=x11-libs/qt-webkit-4.5:4"
DEPEND="${RDEPEND}"
