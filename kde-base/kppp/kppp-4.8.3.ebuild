# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.8.3.ebuild,v 1.3 2012/05/18 20:26:59 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
