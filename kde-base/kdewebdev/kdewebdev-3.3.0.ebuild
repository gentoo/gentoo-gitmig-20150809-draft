# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.3.0.ebuild,v 1.3 2004/08/30 15:45:01 pvdabeel Exp $

inherit kde-dist eutils

DESCRIPTION="KDE web development - Quanta"
KEYWORDS="~x86 ~amd64 ~sparc ppc"
IUSE="doc"
DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )"
