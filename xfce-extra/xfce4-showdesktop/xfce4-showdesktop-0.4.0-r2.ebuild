# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-showdesktop/xfce4-showdesktop-0.4.0-r2.ebuild,v 1.1 2005/10/06 17:45:31 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel plugin to hide/show desktop"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"

goodies_plugin
S=${WORKDIR}/${PN}-plugin
