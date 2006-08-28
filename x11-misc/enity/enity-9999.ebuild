# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/enity/enity-9999.ebuild,v 1.1 2006/08/28 06:17:08 vapier Exp $

ECVS_MODULE="e17/proto/enity"
inherit enlightenment

DESCRIPTION="Tool to display ETK dialogs from the command line and shell scripts"

IUSE="nls"

DEPEND="x11-libs/etk"

src_compile() {
	export MY_ECONF="
		$(use_enable nls)
	"
	enlightenment_src_compile
}
