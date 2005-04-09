# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notes/xfce4-notes-0.10.0-r1.ebuild,v 1.1 2005/04/09 22:50:18 bcowan Exp $

DESCRIPTION="Xfce4 panel sticky notes plugin"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86"

GOODIES_PLUGIN=1

inherit eutils xfce4

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/notes_applet.c.patch
}