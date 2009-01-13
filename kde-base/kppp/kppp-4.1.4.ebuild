# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.1.4.ebuild,v 1.1 2009/01/13 22:39:54 alexxy Exp $

EAPI="2"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

PDEPEND="net-dialup/ppp"
