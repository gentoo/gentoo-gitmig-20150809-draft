# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-qrosp/leechcraft-qrosp-9999.ebuild,v 1.2 2011/12/16 18:45:04 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Qrosp, scrpting support for LeechCraft via Qross."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-libs/qrosscore"
RDEPEND="${DEPEND}"
