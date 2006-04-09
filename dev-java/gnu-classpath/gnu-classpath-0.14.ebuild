# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath/gnu-classpath-0.14.ebuild,v 1.9 2006/04/09 13:20:12 nichoj Exp $

DESCRIPTION="Free core class libraries for use with virtual machines and compilers for the java programming language"
SRC_URI="ftp://ftp.gnu.org/gnu/classpath/classpath-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="x86 ~sparc ppc amd64"
IUSE="gtk xml"

RDEPEND=">=virtual/jre-1.4
	gtk? (
		>=x11-libs/gtk+-2
		>=media-libs/libart_lgpl-2.1
	)
	xml? ( >=dev-libs/libxml2-2.6.8 >=dev-libs/libxslt-1.1.11 )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/zip
	dev-java/jikes"

S=${WORKDIR}/classpath-${PV}

src_compile() {
	econf \
		--enable-jni \
		--with-jikes=/usr/bin/jikes \
		$(use_enable gtk gtk-peer) \
		$(use_enable xml xmlj) \
		--prefix=/usr/share/${PN} \
		 CPPFLAGS="-I/usr/include/freetype2" \
		 ${myjavac} || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
}
