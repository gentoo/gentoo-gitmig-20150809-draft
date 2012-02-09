# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libdsk/libdsk-1.2.1.ebuild,v 1.6 2012/02/09 12:32:40 ago Exp $

inherit java-pkg-opt-2 flag-o-matic autotools

DESCRIPTION="Disk emulation library"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="java"
KEYWORDS="~amd64 ~ppc ~x86"

CDEPEND="sys-libs/zlib
		app-arch/bzip2"
DEPEND="${CDEPEND}
	java? ( >=virtual/jdk-1.5 )"
RDEPEND="${CDEPEND}
	java? ( >=virtual/jdk-1.4 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-java-make-fix.patch
	eautoreconf
}

src_compile() {
	use java && sed -i -e "s!_JINC=\"\$_JTOPDIR/i!_JINC=\"${JAVA_HOME}/i!" configure

	local java_options=""
	if use java; then
		java_options="--with-javac-flags=$(java-pkg_javac-args)"
	fi

	econf \
		--with-zlib \
		--with-bzlib \
		--enable-floppy \
		$(use_with java jni) \
		--with-java-prefix=${JAVA_HOME} \
		"${java_options}" \
		|| die
	emake || die "libdsk make failed!"
}

src_install() {
	emake install transform="s,^,," DESTDIR="${D}" || die
	if use java; then
		java-pkg_dojar "lib/${PN}.jar"
	fi

	dodoc ChangeLog README TODO doc/libdsk.*
}
