# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-cdread/xmms-cdread-0.14a-r1.ebuild,v 1.4 2004/02/09 19:47:46 agriffis Exp $

inherit gnuconfig

DESCRIPTION="XMMS plugin to read audio cdroms as data"
HOMEPAGE="ftp://mud.stack.nl/pub/OuterSpace/willem/"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~ia64"

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
	make DESTDIR=${D} install || die
	dodoc AUTHORS README ChangeLog INSTALL NEWS TODO
}
