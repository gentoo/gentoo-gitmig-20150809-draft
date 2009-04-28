# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgtop-python/libgtop-python-2.24.1.ebuild,v 1.8 2009/04/28 11:41:29 armin76 Exp $

G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="gtop"

inherit gnome-python-common

DESCRIPTION="Python bindings for the libgtop library"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/libgtop-2.13.0
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
