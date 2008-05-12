# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kwin-styles/kdeartwork-kwin-styles-3.5.9.ebuild,v 1.5 2008/05/12 20:02:47 ranger Exp $

ARTS_REQUIRED="never"

KMMODULE=kwin-styles
KMNAME=kdeartwork
EAPI="1"
inherit kde-meta

DESCRIPTION="Window styles for kde"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( >=kde-base/kwin-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"
