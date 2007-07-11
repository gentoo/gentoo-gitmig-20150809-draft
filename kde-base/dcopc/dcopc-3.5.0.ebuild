# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopc/dcopc-3.5.0.ebuild,v 1.8 2007/07/11 01:08:48 mr_bones_ Exp $

KMNAME=kdebindings
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="C bindings for DCOP"
KEYWORDS="~amd64 ~x86" # broken according to upstream - 3.4a1 README=
DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*"

# Make sure to compile this
PATCHES="$FILESDIR/remove-configure.diff"
