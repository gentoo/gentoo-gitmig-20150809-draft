# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/filelight/filelight-4.6.0.ebuild,v 1.2 2011/01/30 09:07:21 xarthisius Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="Filelight creates an interactive map of concentric, segmented rings that help visualise disk usage."

LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !kde-misc/filelight )
	x11-apps/xdpyinfo
"
