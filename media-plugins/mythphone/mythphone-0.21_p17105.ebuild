# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.21_p17105.ebuild,v 1.5 2009/07/19 05:31:37 cardoe Exp $

EAPI=2
inherit qt3 mythtv-plugins

DESCRIPTION="Phone and video calls with SIP."
IUSE="festival"
KEYWORDS="amd64 ppc x86"

RDEPEND="festival? ( app-accessibility/festival )"
DEPEND="${RDEPEND}"

MTVCONF=$(use_enable festival)
