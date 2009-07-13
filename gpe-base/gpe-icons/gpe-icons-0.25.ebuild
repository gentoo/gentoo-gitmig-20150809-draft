# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/gpe-icons/gpe-icons-0.25.ebuild,v 1.6 2009/07/13 23:27:46 miknix Exp $

inherit gpe

DESCRIPTION="Common icons for the GPE Palmtop Environment"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="${IUSE}"
GPE_DOCS="README"

RDEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.6.3"

DEPEND="${DEPEND}
	${RDEPEND}"
