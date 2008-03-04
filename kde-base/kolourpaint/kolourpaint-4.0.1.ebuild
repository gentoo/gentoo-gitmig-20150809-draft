# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.0.1.ebuild,v 1.2 2008/03/04 05:08:46 jer Exp $

EAPI="1"

KMNAME=kdegraphics
inherit kde4-meta eutils

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug htmlhandbook"
LICENSE="BSD"

DEPEND="kde-base/qimageblitz"
RDEPEND="${DEPEND}"
