# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight/filelight-1.9_rc3.ebuild,v 1.5 2009/11/10 02:30:09 fauli Exp $

EAPI=2
KMNAME="playground/utils"
KDE_MINIMAL=4.2

inherit kde4-base

MY_P=${P/_}

DESCRIPTION="Filelight creates an interactive map of concentric, segmented rings that help visualise disk usage."
HOMEPAGE="http://kde-apps.org/content/show.php/filelight?content=99561"
SRC_URI="http://kde-apps.org/CONTENT/content-files/99561-${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE="debug"

RDEPEND="x11-apps/xdpyinfo"

S=${WORKDIR}/${MY_P}
