# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopc/dcopc-3.5.10.ebuild,v 1.4 2009/07/06 18:07:12 ranger Exp $

KMNAME=kdebindings
EAPI="1"
inherit kde-meta

DESCRIPTION="C bindings for DCOP"
KEYWORDS="amd64 ~ppc ppc64 x86" # broken according to upstream - 3.4a1 README=
DEPEND="dev-libs/glib:1
	x11-libs/gtk+:1"
RDEPEND="${DEPEND}"
IUSE=""

# Make sure to compile this
PATCHES=( "${FILESDIR}/remove-configure.diff" )
