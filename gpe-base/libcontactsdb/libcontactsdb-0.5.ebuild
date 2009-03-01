# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libcontactsdb/libcontactsdb-0.5.ebuild,v 1.1 2009/03/01 00:37:57 solar Exp $

GPE_TARBALL_SUFFIX="bz2"

inherit gpe

DESCRIPTION="Database access library for GPE calendar"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS="ChangeLog"

RDEPEND="${RDEPEND}
	gpe-base/libgpepimc
	=dev-db/sqlite-2.8*"

DEPEND="${DEPEND} ${RDEPEND}"
