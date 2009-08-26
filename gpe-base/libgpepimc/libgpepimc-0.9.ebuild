# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libgpepimc/libgpepimc-0.9.ebuild,v 1.4 2009/08/26 16:04:16 miknix Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe autotools

DESCRIPTION="Common code for PIM applications of the GPE Palmtop Environment"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="doc"
GPE_DOCS="ChangeLog"
GPECONF="${GPECONF} $(use_enable doc gtk-doc)"

RDEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	gpe-base/libgpewidget
	dev-db/sqlite"

DEPEND="${DEPEND}
	${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.2 )
	dev-util/gtk-doc-am"

src_unpack() {
	gpe_src_unpack "$@"

	if ! use doc; then
		sed -i -e 's;SUBDIRS = doc;SUBDIRS = ;' Makefile.am \
		|| die "sed failed"
	fi

	eautoreconf
}
