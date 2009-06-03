# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kommander/kommander-3.5.10.ebuild,v 1.3 2009/06/03 14:16:28 ranger Exp $

KMNAME=kdewebdev
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE dialog system for scripting"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

PATCHES=( "${FILESDIR}/kommander-3.5.9-visibility.patch" )
