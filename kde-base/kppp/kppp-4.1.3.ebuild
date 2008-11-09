# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.1.3.ebuild,v 1.1 2008/11/09 01:56:47 scarabeus Exp $

EAPI="2"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

PDEPEND="net-dialup/ppp"
