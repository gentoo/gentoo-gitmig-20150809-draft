# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libschedule/libschedule-0.17.ebuild,v 1.1 2009/03/01 01:00:27 solar Exp $

GPE_TARBALL_SUFFIX="bz2"

inherit gpe

DESCRIPTION="RTC alarm handling library for the GPE Palmtop Environment"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS="ChangeLog"

RDEPEND="${RDEPEND}
	gpe-base/libgpewidget
	>=dev-libs/glib-2.6.3"

DEPEND="${DEPEND}
	${RDEPEND}"

src_install() {
	gpe_src_install "$@"
	make DESTDIR="${D}" PREFIX=/usr install-devel
}
