# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/ebook-libgnomeui/ebook-libgnomeui-1.0.ebuild,v 1.11 2004/08/01 20:46:51 bass Exp $

DESCRIPTION="libgnomeui 1.0  EBook."

EBOOKNAME="libgnomeui"
EBOOKVERSION="1.0"
NOVERSION="1"

inherit eutils ebook

src_unpack() {
	unpack libgnomeui.tar.gz
	cd ${S}
	epatch ${FILESDIR}/ebook-libgnome-book.devhelp.patch
}
