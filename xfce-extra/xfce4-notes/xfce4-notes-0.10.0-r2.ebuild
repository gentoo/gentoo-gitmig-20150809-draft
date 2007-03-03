# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notes/xfce4-notes-0.10.0-r2.ebuild,v 1.6 2007/03/03 14:09:25 nixnut Exp $

inherit xfce42 eutils

DESCRIPTION="Xfce4 panel sticky notes plugin"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"

goodies_plugin

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/notes_applet.c.patch
}
