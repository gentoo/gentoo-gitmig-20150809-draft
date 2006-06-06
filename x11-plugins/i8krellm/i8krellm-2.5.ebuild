# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/i8krellm/i8krellm-2.5.ebuild,v 1.7 2006/06/06 11:14:58 genstef Exp $

DESCRIPTION="GKrellM2 Plugin for the Dell Inspiron and Latitude notebooks"
SRC_URI="http://www.coding-zone.com/${P}.tar.gz"
HOMEPAGE="http://www.coding-zone.com/?page=i8krellm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa"

DEPEND="app-admin/gkrellm
	x11-libs/gtk+
	>=app-laptop/i8kutils-1.5"

src_compile() {

	if [ -f /usr/bin/gkrellm ]
	then
		emake i8krellm1 || die
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		emake || die
	fi
}

src_install () {

	if [ -f /usr/bin/gkrellm ]
	then
		insinto /usr/lib/gkrellm/plugins
		doins i8krellm1.so
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		insinto /usr/lib/gkrellm2/plugins
		doins i8krellm.so
	fi
	dodoc README Changelog AUTHORS

	einfo "PLEASE NOTE that the module is renamed:"
	einfo "       gkrellm2: i8krellm (it was i8krellm2 in the past)"
	einfo "       grellm:   i8krellm1 (the former i8krellm)"
	einfo "Make sure to switch your plugin to the new one."
}
