# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker-scripts/knewsticker-scripts-3.5.10.ebuild,v 1.7 2009/07/12 13:03:18 armin76 Exp $
KMNAME=kdeaddons
EAPI="1"
inherit kde-meta

DESCRIPTION="Kicker applet - RSS news ticker"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( >=kde-base/knewsticker-${PV}:${SLOT} >=kde-base/kdenetwork-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"
