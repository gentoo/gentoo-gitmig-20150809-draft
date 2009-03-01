# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libgpepimc/libgpepimc-0.9.ebuild,v 1.1 2009/03/01 00:06:25 solar Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe

DESCRIPTION="Common code for PIM applications of the GPE Palmtop Environment"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS="ChangeLog"

RDEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	gpe-base/libgpewidget
	dev-db/sqlite"

DEPEND="${DEPEND}
	${RDEPEND}"
