# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfontenc/libfontenc-1.0.4.ebuild,v 1.8 2007/06/24 22:39:12 vapier Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org fontenc library"

KEYWORDS="~alpha amd64 arm hppa ia64 m68k mips ~ppc ppc64 s390 sh ~sparc x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"

CONFIGURE_OPTIONS="--with-encodingsdir=/usr/share/fonts/encodings"
