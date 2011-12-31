# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-tabslist/leechcraft-tabslist-0.4.97.ebuild,v 1.1 2011/12/31 12:17:45 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Quick navigation between tabs in LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
