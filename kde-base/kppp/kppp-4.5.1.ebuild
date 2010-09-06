# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.5.1.ebuild,v 1.1 2010/09/06 01:02:51 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS=""
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
