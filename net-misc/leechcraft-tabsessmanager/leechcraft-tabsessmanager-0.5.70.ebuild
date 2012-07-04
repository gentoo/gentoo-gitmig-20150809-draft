# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-tabsessmanager/leechcraft-tabsessmanager-0.5.70.ebuild,v 1.2 2012/07/04 21:17:16 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides session restore between LeechCraft runs as well as manual saves/restores"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
