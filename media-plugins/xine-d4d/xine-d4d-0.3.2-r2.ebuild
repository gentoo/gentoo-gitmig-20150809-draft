# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xine-d4d/xine-d4d-0.3.2-r2.ebuild,v 1.4 2003/02/28 16:54:59 liquidx Exp $

DESCRIPTION="Captain CSS plugin for the xine media player."
HOMEPAGE="http://members.fortunecity.de/captaincss/"
LICENSE="GPL-2"

DEPEND="=media-libs/xine-lib-0.9*"

SLOT="0"
KEYWORDS="x86 ppc"

SRC_URI="http://members.fortunecity.de/captaincss/d4d${PV//./}.txt"
S="${WORKDIR}/${PN/-/_}_plugin-${PV}"

src_unpack() {

	cp ${DISTDIR}/${A} . && chmod +x ${A} && ./${A} && \
	tar zxf ${WORKDIR}/${PN/-/_}_plugin-${PV}.tar.gz || \
	die "Unpacking failed"

	# xine-0.9.13 compatibility patch.
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die "Patching failed"

}

src_compile() {

	econf || die "./configure failed"
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
