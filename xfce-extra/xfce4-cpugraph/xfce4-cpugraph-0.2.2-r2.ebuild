# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cpugraph/xfce4-cpugraph-0.2.2-r2.ebuild,v 1.3 2006/12/02 09:48:35 dev-zero Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel cpu load graphing plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

goodies_plugin
S=${WORKDIR}/${MY_P/-${PV}/}
