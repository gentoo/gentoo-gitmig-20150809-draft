# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/gpe-icons/gpe-icons-0.25.ebuild,v 1.1 2009/02/28 23:51:52 solar Exp $

inherit gpe

DESCRIPTION="Common icons for the GPE Palmtop Environment"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
DOCS="ChangeLog"

RDEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.6.3"

DEPEND="${DEPEND}
	${RDEPEND}"
