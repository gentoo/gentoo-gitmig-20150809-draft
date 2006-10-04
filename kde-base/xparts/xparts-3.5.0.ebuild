# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/xparts/xparts-3.5.0.ebuild,v 1.7 2006/10/04 15:50:41 flameeyes Exp $

KMNAME=kdebindings
KMEXTRACTONLY="dcopc"
KMCOPYLIB="libdcopc dcopc"
KM_MAKEFILESREV=1
MAXKDEVER=3.5.5
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Allows embedding of generic XParts as KDE KParts"
KEYWORDS="~amd64 ~x86" # broken according to upstream - 3.4a1 README
IUSE="mozilla"
DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

src_unpack() {
	kde-meta_src_unpack

	# disable mozilla bindings/xpart, because configure doesn't seem to do so
	# even when it doesn't detect the mozilla headers
	sed -i -e 's:mozilla::' "${S}/xparts/Makefile.am"
}

