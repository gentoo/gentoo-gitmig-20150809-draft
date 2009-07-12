# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kommander/kommander-3.5.10.ebuild,v 1.7 2009/07/12 10:46:34 armin76 Exp $

KMNAME=kdewebdev
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE dialog system for scripting"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

PATCHES=( "${FILESDIR}/kommander-3.5.9-visibility.patch" )
