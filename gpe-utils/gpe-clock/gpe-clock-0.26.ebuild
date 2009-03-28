# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-utils/gpe-clock/gpe-clock-0.26.ebuild,v 1.1 2009/03/28 22:43:09 miknix Exp $

GPE_TARBALL_SUFFIX="gz"
GPE_MIRROR="http://gpe.linuxtogo.org/download/source"
inherit eutils gpe

DESCRIPTION="The GPE panel clock"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
RDEPEND="gpe-base/libgpewidget gpe-base/libgpelaunch gpe-base/libschedule"
IUSE="${IUSE}"
