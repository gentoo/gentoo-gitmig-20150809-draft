# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libtododb/libtododb-0.11.ebuild,v 1.2 2009/03/01 01:05:31 miknix Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe

DESCRIPTION="Database access library for GPE to-do list"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS="ChangeLog"

RDEPEND="${RDEPEND}
	>=gpe-base/libgpewidget-0.113
	>=gpe-base/libgpepimc-0.6
	=dev-db/sqlite-2.8*"

DEPEND="${DEPEND} ${RDEPEND}"
