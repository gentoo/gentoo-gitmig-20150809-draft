# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystemlog/ksystemlog-4.3.3.ebuild,v 1.5 2009/12/05 05:13:08 abcd Exp $

EAPI="2"

KMNAME="kdeadmin"

inherit kde4-meta

DESCRIPTION="KDE system log viewer"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug +handbook"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
