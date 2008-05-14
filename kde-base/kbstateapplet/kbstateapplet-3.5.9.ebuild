# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbstateapplet/kbstateapplet-3.5.9.ebuild,v 1.8 2008/05/14 11:01:36 corsair Exp $
KMNAME=kdeaccessibility
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE panel applet that displays the keyboard status"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86"
IUSE=""
DEPEND="|| ( >=kde-base/kcontrol-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"

RDEPEND="${DEPEND}"
