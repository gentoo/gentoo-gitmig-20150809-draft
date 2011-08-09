# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.6.5.ebuild,v 1.2 2011/08/09 17:12:29 hwoarang Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
