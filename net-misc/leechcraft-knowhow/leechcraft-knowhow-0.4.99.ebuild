# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-knowhow/leechcraft-knowhow-0.4.99.ebuild,v 1.2 2012/02/04 19:15:51 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="KnowHow, plugin for showing Tips of the Day in LeechCraft"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
