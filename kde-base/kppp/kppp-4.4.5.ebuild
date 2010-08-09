# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.4.5.ebuild,v 1.5 2010/08/09 17:33:56 scarabeus Exp $

EAPI="3"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="debug +handbook"

RDEPEND="
	net-dialup/ppp
"
