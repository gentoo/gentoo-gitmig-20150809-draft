# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/filelight/filelight-0.6.4.1-r1.ebuild,v 1.4 2004/07/11 12:37:08 carlo Exp $

inherit kde
need-kde 3

DESCRIPTION="Filelight is a tool to display where the space is used on the harddisk"
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/${PN}/${PN}-0.6.4-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="arts"

S=${WORKDIR}/${PN}-0.6.4

src_compile() {
	local myconf

	use arts || myconf="${myconf} --without-arts"

	kde_src_compile all
}
