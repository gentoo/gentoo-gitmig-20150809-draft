# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kget/kget-3.5.10.ebuild,v 1.4 2009/06/03 14:10:10 ranger Exp $

KMNAME=kdenetwork
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="x11-libs/libXext"
