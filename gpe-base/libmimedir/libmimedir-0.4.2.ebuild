# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libmimedir/libmimedir-0.4.2.ebuild,v 1.1 2009/03/01 00:16:31 solar Exp $

GPE_TARBALL_SUFFIX="gz"
GPE_MIRROR="http://gpe.linuxtogo.org/download/source"

inherit eutils gpe

DESCRIPTION="${PN} - GPE Palmtop Environment"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="doc"
DOCS=""

RDEPEND="${RDEPEND}
	!dev-libs/libmimedir
	>=gpe-base/libgpewidget-0.102"

DEPEND="${DEPEND} ${RDEPEND}"

GPECONF="$(use_enable doc gtk-doc)"
