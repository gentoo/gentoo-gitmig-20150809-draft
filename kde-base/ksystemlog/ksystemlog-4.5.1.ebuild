# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystemlog/ksystemlog-4.5.1.ebuild,v 1.1 2010/09/06 01:22:41 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdeadmin"

inherit kde4-meta

DESCRIPTION="KDE system log viewer"
KEYWORDS=""
IUSE="debug"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
