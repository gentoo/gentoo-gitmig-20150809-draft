# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kviewshell/kviewshell-3.5.9.ebuild,v 1.7 2008/05/14 18:12:21 corsair Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE: Generic framework for viewer applications"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| ( >=kde-base/kdebase-kioslaves-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"
