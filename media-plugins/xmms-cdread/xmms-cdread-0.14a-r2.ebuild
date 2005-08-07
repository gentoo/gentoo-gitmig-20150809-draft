# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-cdread/xmms-cdread-0.14a-r2.ebuild,v 1.3 2005/08/07 13:28:08 hansmi Exp $

IUSE=""

inherit gnuconfig eutils

DESCRIPTION="XMMS plugin to read audio cdroms as data"
HOMEPAGE="ftp://mud.stack.nl/pub/OuterSpace/willem/"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ia64 ppc ppc64 sparc x86"

DEPEND=">=media-sound/xmms-1.2.8"

src_unpack () {
	unpack ${A} && cd ${S} || die

	# Patch to make this plugin compatible with xmms-1.2.8
	epatch ${FILESDIR}/${P}-xmms-1.2.8.patch

	# The following patch is particularly for ppc but should apply
	# cleanly for all arches (it's #ifdef'd inside the patch)
	epatch ${FILESDIR}/endian.patch

	# Recognize newer arches
	gnuconfig_update || die
}

src_install () {
	exeinto `xmms-config --input-plugin-dir`
	doexe .libs/libcdread.so || die
	dodoc AUTHORS README ChangeLog NEWS TODO
}
