# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.1.2.ebuild,v 1.2 2008/10/21 11:17:27 jmbsvicetto Exp $

EAPI="2"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

PDEPEND="net-dialup/ppp"
