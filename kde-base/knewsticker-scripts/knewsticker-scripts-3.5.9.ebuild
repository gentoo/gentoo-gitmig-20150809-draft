# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker-scripts/knewsticker-scripts-3.5.9.ebuild,v 1.8 2008/05/18 21:21:48 maekke Exp $
KMNAME=kdeaddons
EAPI="1"
inherit kde-meta

DESCRIPTION="Kicker applet - RSS news ticker"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( >=kde-base/knewsticker-${PV}:${SLOT} >=kde-base/kdenetwork-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"
