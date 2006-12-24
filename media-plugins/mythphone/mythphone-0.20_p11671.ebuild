# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.20_p11671.ebuild,v 1.2 2006/12/24 08:04:30 cardoe Exp $

inherit  mythtv-plugins

DESCRIPTION="Phone and video calls with SIP."
IUSE="festival"
KEYWORDS="amd64 ppc x86"

RDEPEND="festival? ( app-accessibility/festival )"
DEPEND="${RDEPEND}"

MTVCONF=$(use_enable festival)
