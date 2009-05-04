# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pixman/pixman-0.11.6.ebuild,v 1.4 2009/05/04 15:17:31 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Low-level pixel manipulation routines"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="altivec mmx sse2"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable altivec vmx) $(use_enable mmx)
	$(use_enable sse2) --disable-gtk"
}
