# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/freedesktop-icon-theme/freedesktop-icon-theme-0.ebuild,v 1.5 2011/12/01 17:35:08 darkside Exp $

EAPI=4

DESCRIPTION="A virtual to choose between different icon themes"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND="|| ( x11-themes/tango-icon-theme
	x11-themes/gnome-icon-theme
	kde-base/oxygen-icons
	lxde-base/lxde-icon-theme
	x11-themes/faenza-icon-theme )"
