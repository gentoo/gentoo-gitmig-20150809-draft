# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtsharp/qtsharp-3.3.1.ebuild,v 1.5 2004/12/12 19:07:01 danarmak Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
inherit kde-meta

DESCRIPTION="C# bindings for QT"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-dotnet/pnet"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

pkg_setup() {
	ewarn "This package is outdated and should be replaced by dev-dotnet/qtsharp,"
	ewarn "except that dev-dotnet/qtsharp doesn't fully work yet (?), so this is still here."
}
