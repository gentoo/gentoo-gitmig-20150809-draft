# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/etk/etk-9999.ebuild,v 1.1 2005/11/09 00:03:22 vapier Exp $

ECVS_MODULE="e17/proto/etk"
inherit enlightenment

DESCRIPTION="toolkit based on the EFL"

IUSE="nls"

DEPEND="x11-libs/evas
	media-libs/edje
	x11-libs/ecore"

src_compile() {
	export MY_ECONF="
		$(use_enable nls)
	"
	enlightenment_src_compile
}
