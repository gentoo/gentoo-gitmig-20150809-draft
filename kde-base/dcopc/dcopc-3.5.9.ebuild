# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopc/dcopc-3.5.9.ebuild,v 1.2 2008/05/19 23:31:17 carlo Exp $

KMNAME=kdebindings
EAPI="1"
inherit kde-meta

DESCRIPTION="C bindings for DCOP"
KEYWORDS="amd64 ~ppc ~ppc64 x86" # broken according to upstream - 3.4a1 README=
DEPEND="dev-libs/glib:1
	x11-libs/gtk+:1"

# Make sure to compile this
PATCHES="${FILESDIR}/remove-configure.diff"
