# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-3.5.9.ebuild,v 1.7 2008/05/18 14:34:35 maekke Exp $
KMNAME=kdegames
EAPI="1"
inherit kde-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=""

src_compile() {
	# For now, make sure things aren't installed GUID root (which you apparently
	# can get with some combination of configure parameters).
	# The question about the games group owning this is apparently still open?
	myconf="$myconf --disable-setgid"
	kde-meta_src_compile
}
