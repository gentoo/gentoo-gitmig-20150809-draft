# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-icegradient/gtk-engines-icegradient-0.0.5-r1.ebuild,v 1.9 2004/07/15 01:05:04 agriffis Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+1 Ice Gradient Theme Engine (based on Thinice)"
SRC_URI="mirror://debian/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
LICENSE="GPL-2"
SLOT="1"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${P}.orig

DOCS="CUSTOMIZATION"
