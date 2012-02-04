# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-qrosp/leechcraft-qrosp-0.4.99.ebuild,v 1.2 2012/02/04 19:17:02 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Qrosp, scrpting support for LeechCraft via Qross."

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-libs/qrosscore"
RDEPEND="${DEPEND}"
