# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-showdesktop/xfce4-showdesktop-0.4.0-r1.ebuild,v 1.8 2005/06/18 18:51:58 corsair Exp $

DESCRIPTION="Xfce4 panel plugin to hide/show desktop"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"

GOODIES_PLUGIN=1
XFCE_S=${WORKDIR}/${PN}-plugin

inherit xfce4
