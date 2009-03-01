# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libgpevtype/libgpevtype-0.50.ebuild,v 1.1 2009/03/01 00:31:48 solar Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe

DESCRIPTION="Data interchange library for the GPE Palmtop Environment"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS="ChangeLog"

RDEPEND="${RDEPEND}
	gpe-base/libtododb
	>=dev-libs/glib-2.2
	>=gpe-base/libmimedir-0.4.2
	>=gpe-base/libeventdb-0.29"

DEPEND="${DEPEND}
	${RDEPEND}"

