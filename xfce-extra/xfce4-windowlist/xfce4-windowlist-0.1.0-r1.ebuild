# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-windowlist/xfce4-windowlist-0.1.0-r1.ebuild,v 1.8 2007/03/11 10:47:49 drac Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel windowlist plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

goodies_plugin

S=${WORKDIR}/${MY_P/-${PV}/}
