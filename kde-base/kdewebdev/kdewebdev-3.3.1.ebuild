# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.3.1.ebuild,v 1.4 2004/11/04 13:45:22 weeve Exp $

inherit kde-dist eutils

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~amd64 ~hppa ~ppc sparc ~x86 ~alpha"
IUSE="doc"

DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )"
