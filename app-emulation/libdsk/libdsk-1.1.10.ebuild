# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libdsk/libdsk-1.1.10.ebuild,v 1.3 2006/11/07 09:12:13 dragonheart Exp $

inherit java-pkg java-utils-2 flag-o-matic

DESCRIPTION="Disk emulation library"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="java"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="sys-libs/zlib
	app-arch/bzip2
	java? ( >=virtual/jdk-1.4 )"

pkg_setup() {
	use java && java-pkg_pkg_setup
}

src_compile() {
	use java && sed -i -e "s!_JINC=\"\$_JTOPDIR/i!_JINC=\"${JAVA_HOME}/i!" configure
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
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog README TODO doc/libdsk.*
}
