# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtsharp/qtsharp-3.3.1.ebuild,v 1.1 2004/11/06 17:23:33 danarmak Exp $

KMNAME=kdebindings
inherit kde-meta

DESCRIPTION="C# bindings for QT"
KEYWORDS="~x86"
IUSE=""
# DEPEND="dev-dotnet/csant" -- TBA when a csant ebuild exists. Disabled for now to let repoman let me commit this.
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

pkg_setup() {
    ewarn "This package is considered broken by upstream. You're on your own."
    ewarn "This won't build. Portage doesn't have a csant ebuild yet."
}
