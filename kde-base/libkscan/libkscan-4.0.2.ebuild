# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkscan/libkscan-4.0.2.ebuild,v 1.2 2008/03/29 01:00:03 zlin Exp $

EAPI="1"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="KDE scanner library"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"
LICENSE="LGPL-2"

DEPEND="kde-base/qimageblitz
	media-gfx/sane-backends"
RDEPEND="${DEPEND}"
