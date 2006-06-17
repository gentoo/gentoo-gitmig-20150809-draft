# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/ebook-libgnomeui/ebook-libgnomeui-1.0.ebuild,v 1.13 2006/06/17 05:27:08 mr_bones_ Exp $

EBOOKNAME="libgnomeui"
EBOOKVERSION="1.0"
NOVERSION="1"

inherit eutils ebook

DESCRIPTION="libgnomeui 1.0  EBook."

src_unpack() {
	unpack libgnomeui.tar.gz
	cd ${S}
	epatch ${FILESDIR}/ebook-libgnome-book.devhelp.patch
}
