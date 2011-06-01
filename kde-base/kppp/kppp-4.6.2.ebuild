# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.6.2.ebuild,v 1.4 2011/06/01 18:46:34 ranger Exp $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
