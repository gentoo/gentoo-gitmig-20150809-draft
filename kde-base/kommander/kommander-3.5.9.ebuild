# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kommander/kommander-3.5.9.ebuild,v 1.5 2008/05/12 14:27:09 armin76 Exp $

KMNAME=kdewebdev
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE dialog system for scripting"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

PATCHES=( "${FILESDIR}/${P}-visibility.patch" )
