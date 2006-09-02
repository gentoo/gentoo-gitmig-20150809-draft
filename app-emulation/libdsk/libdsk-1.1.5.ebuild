# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libdsk/libdsk-1.1.5.ebuild,v 1.4 2006/09/02 16:10:24 blubb Exp $

DESCRIPTION="Disk emulation library"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="java"
KEYWORDS="amd64 ppc x86"

DEPEND="sys-libs/zlib
	app-arch/bzip2
	java? ( >=virtual/jdk-1.4 )"

src_compile() {
	econf \
		--with-zlib \
		--with-bzlib \
		--enable-floppy \
		$(use_with java jni) \
		--with-java-prefix=${JAVA_HOME} \
		|| die
	emake || die "libdsk make failed!"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog README TODO doc/libdsk.*
}
