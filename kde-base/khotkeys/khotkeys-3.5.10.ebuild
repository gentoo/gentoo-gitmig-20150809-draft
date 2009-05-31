# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khotkeys/khotkeys-3.5.10.ebuild,v 1.3 2009/05/31 19:22:11 nixnut Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE: hotkey daemon"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="x11-libs/libXtst"
