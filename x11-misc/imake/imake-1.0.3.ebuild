# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/imake/imake-1.0.3.ebuild,v 1.1 2010/04/17 13:30:30 scarabeus Exp $

EAPI=3

XORG_STATIC=no
inherit xorg-2

DESCRIPTION="C preprocessor interface to the make utility"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-misc/xorg-cf-files"
DEPEND="${RDEPEND}
	x11-proto/xproto"
