# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.3.0_alpha1.ebuild,v 1.2 2004/06/14 08:17:51 lv Exp $

inherit kde-dist eutils

DESCRIPTION="KDE web development - Quanta"
KEYWORDS="~x86 ~amd64"
DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )"
