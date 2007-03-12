# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/i8krellm/i8krellm-2.5.ebuild,v 1.9 2007/03/12 21:13:44 lack Exp $

inherit gkrellm-plugin

DESCRIPTION="GKrellM2 Plugin for the Dell Inspiron and Latitude notebooks"
SRC_URI="http://www.coding-zone.com/${P}.tar.gz"
HOMEPAGE="http://www.coding-zone.com/?page=i8krellm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa"

RDEPEND=">=app-laptop/i8kutils-1.5"
DEPEND="${RDEPEND}"

pkg_postinst() {
	einfo "PLEASE NOTE that the module is renamed:"
	einfo "       gkrellm2: i8krellm (it was i8krellm2 in the past)"
	einfo "Make sure to switch your plugin to the new one."
}
