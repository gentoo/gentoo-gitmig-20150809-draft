# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxmms/roxmms-0.3.6.ebuild,v 1.1 2004/12/09 19:08:44 sergey Exp $

DESCRIPTION="ROX-MMS - An XMMS control applet for the ROX desktop"

MY_PN="ROX-MMS"

HOMEPAGE=" http://www.skepticats.com/rox/rox-mms.html"

SRC_URI="http://www.skepticats.com/rox/dist/${MY_PN}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="media-sound/xmms"

ROX_CLIB_VER=2.1.1

APPNAME=${MY_PN}

S=${WORKDIR}

inherit rox
