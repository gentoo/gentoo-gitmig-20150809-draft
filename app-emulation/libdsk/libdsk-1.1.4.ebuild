# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libdsk/libdsk-1.1.4.ebuild,v 1.1 2005/06/26 11:00:59 dragonheart Exp $

inherit eutils

DESCRIPTION="Disk emulation library"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="java"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="sys-libs/zlib
	app-arch/bzip2
	java? ( virtual/jdk dev-java/java-config )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-destdirfix.patch
}

src_compile() {
	econf \
		--with-zlib \
		--with-bzlib \
		--enable-floppy \
		$(use_with java jni) \
		--with-java-prefix=$(java-config -O) \
		|| die
	emake || die "libdsk make failed!"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README TODO doc/libdsk.*
}
