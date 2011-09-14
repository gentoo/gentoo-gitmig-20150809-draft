# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-auscrie/leechcraft-auscrie-0.4.90.ebuild,v 1.1 2011/09/14 17:01:45 maksbotan Exp $

EAPI="2"

inherit leechcraft

DESCRIPTION="Auscrie, LeechCraft auto screenshooter"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
