# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/i8krellm/i8krellm-2.3.ebuild,v 1.7 2004/07/15 01:00:01 agriffis Exp $

IUSE="gtk2"

DESCRIPTION="GKrellM2 Plugin for the Dell Inspiron and Latitude notebooks"
SRC_URI="http://www.coding-zone.com/${P}.tar.gz"
HOMEPAGE="http://www.coding-zone.com/i8krellm.phtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha -mips -hppa"

DEPEND="app-admin/gkrellm
	x11-libs/gtk+
	gtk2? ( =x11-libs/gtk+-2*
		=app-admin/gkrellm-2* )
	>=app-laptop/i8kutils-1.5"

src_compile() {

	if [ -f /usr/bin/gkrellm ]
	then
		emake || die
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		emake i8krellm2 || die
	fi
}

src_install () {

	if [ -f /usr/bin/gkrellm ]
	then
		insinto /usr/lib/gkrellm/plugins
		doins i8krellm.so
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		insinto /usr/lib/gkrellm2/plugins
		doins i8krellm2.so
	fi
	dodoc README Changelog AUTHORS
}
