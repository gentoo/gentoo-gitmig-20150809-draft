# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/leif/leif-12.1_p2002.ebuild,v 1.1 2005/03/30 17:18:05 usata Exp $

inherit iiimf eutils

DESCRIPTION="Language Engine is a component that provide actual Input Method service for IIIMF"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="dev-libs/eimil"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}/testEIMIL
	sed -i -e 's,$(IM_LIBDIR)/EIMIL,/usr/lib,g' Makefile.* || die
	cd ${S}
	sed -i -e '/LE_TARGETS/s/chewing//g' configure.ac || die
}

#src_compile() {
#	./autogen.sh
#	econf || die
#	emake -j1 || die
#}

src_install() {
	make DESTDIR=${D} \
		prefix=/usr \
		install || die

	dodoc ChangeLog
	for d in canna cm newpy sampleja* ude unit template ; do
		docinto $d
		dodoc ChangeLog README
	done
}
