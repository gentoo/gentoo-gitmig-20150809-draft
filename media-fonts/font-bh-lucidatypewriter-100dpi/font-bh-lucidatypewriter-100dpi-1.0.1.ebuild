# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bh-lucidatypewriter-100dpi/font-bh-lucidatypewriter-100dpi-1.0.1.ebuild,v 1.5 2010/07/22 15:00:39 maekke Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Bigelow & Holmes Lucida bitmap fonts"

KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"
