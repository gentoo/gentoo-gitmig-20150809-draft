# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/liboxygenstyle/liboxygenstyle-4.7.4.ebuild,v 1.3 2012/01/09 17:37:32 phajdan.jr Exp $

EAPI=4

KMNAME="kde-workspace"
KMMODULE="libs/oxygen"
inherit kde4-meta

DESCRIPTION="Library to support the Oxygen style in KDE"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

PATCHES=( "${FILESDIR}/${PN}-4.7.4-enablefinal.patch" )
