# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopc/dcopc-3.5.0.ebuild,v 1.3 2006/03/22 20:14:54 danarmak Exp $

KMNAME=kdebindings
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="C bindings for DCOP"
KEYWORDS="~amd64 ~x86" # broken according to upstream - 3.4a1 README=
DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*"

# Make sure to compile this
PATCHES="$FILESDIR/remove-configure.diff"

