# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopc/dcopc-3.3.1.ebuild,v 1.5 2005/02/11 13:15:36 danarmak Exp $

KMNAME=kdebindings
MAXKDEVER=3.3.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="C bindings for DCOP"
KEYWORDS="x86"
DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*"

# Make sure to compile this
PATCHES="$FILESDIR/remove-configure.diff"

