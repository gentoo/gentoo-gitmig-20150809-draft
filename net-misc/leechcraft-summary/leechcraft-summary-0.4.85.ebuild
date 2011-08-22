# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-summary/leechcraft-summary-0.4.85.ebuild,v 1.1 2011/08/22 19:00:06 maksbotan Exp $

EAPI="2"

inherit leechcraft

DESCRIPTION="Summary plugin for Leechcraf"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
