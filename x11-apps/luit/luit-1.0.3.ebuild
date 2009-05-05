# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/luit/luit-1.0.3.ebuild,v 1.3 2009/05/05 06:36:52 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Locale and ISO 2022 support for Unicode terminals"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libX11
	x11-libs/libfontenc"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--with-localealiasfile=${XDIR}/share/X11/locale/locale.alias"
