# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-0.9.9.4.ebuild,v 1.5 2002/08/01 11:59:02 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
SRC_URI="mirror://sourceforge/gnump3d/${P}.tar.gz"
HOMEPAGE="http://gnump3d.sourceforge.net/"

DEPEND="virtual/glibc"
RDEPEND=">=sys-devel/perl-5.6.1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/mp3d.conf-gentoo.patch || die
	patch -p1 <${FILESDIR}/doc-Makefile-gentoo.patch || die
}

src_compile() {
	make PREFIX=/usr \
		CONFIGDIR=/etc/${PN} \
		TEMPLATEDIR=/usr/share/${PN} \
		DEFAULT_CFLAGS="-I. ${CXXFLAGS}" \
		linux || die
}

src_install() {
	dodir /usr/share/${PN}
	make PREFIX=${D}/usr \
		CONFIGDIR=${D}/etc/${PN} \
		TEMPLATEDIR=${D}/usr/share/${PN} \
		MANDIR=${D}/usr/share/man/man1 \
		DESTDIR=${D} install || die

	dodoc AUTHORS BUGS CHANGELOG COPYING README* TODO
	docinto templates; dodoc templates/README* 

	exeinto /etc/init.d
	newexe ${FILESDIR}/gnump3d.rc6 gnump3d
}
