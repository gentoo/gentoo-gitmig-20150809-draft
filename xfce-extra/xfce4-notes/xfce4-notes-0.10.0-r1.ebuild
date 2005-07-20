# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notes/xfce4-notes-0.10.0-r1.ebuild,v 1.3 2005/07/20 12:30:31 corsair Exp $

GOODIES_PLUGIN=1

inherit xfce4 eutils

DESCRIPTION="Xfce4 panel sticky notes plugin"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/notes_applet.c.patch
}
