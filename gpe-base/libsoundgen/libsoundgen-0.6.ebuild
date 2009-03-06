# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libsoundgen/libsoundgen-0.6.ebuild,v 1.1 2009/03/06 17:50:52 solar Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe

DESCRIPTION="Sound generator library for the GPE Palmtop Environment and gpe-calendar."

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS=""

RDEPEND="${RDEPEND}
	>=gpe-base/libgpewidget-0.102"

DEPEND="${DEPEND}
	${RDEPEND}"

src_unpack() {
	gpe_src_unpack "$@"

	sed -i -e 's;PREFIX = /usr/local;;' Makefile

	echo "install: install-devel" >> Makefile
}
