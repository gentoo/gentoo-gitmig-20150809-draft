# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/estickies/estickies-9999.ebuild,v 1.1 2006/08/28 06:21:28 vapier Exp $

ECVS_MODULE="e17/proto/estickies"
inherit enlightenment

DESCRIPTION="A sticky notes application based on ETK"

IUSE="nls"

DEPEND="x11-libs/etk
	dev-libs/eet"

src_compile() {
	export MY_ECONF="
		$(use_enable nls)
	"
	enlightenment_src_compile
}
