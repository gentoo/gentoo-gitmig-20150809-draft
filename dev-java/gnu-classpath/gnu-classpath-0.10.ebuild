# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath/gnu-classpath-0.10.ebuild,v 1.2 2004/07/14 01:55:37 agriffis Exp $

DESCRIPTION="Free core class libraries for use with virtual machines and compilers for the java programming language"
SRC_URI="ftp://ftp.gnu.org/gnu/classpath/classpath-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/"
IUSE="jikes"
RDEPEND=">=virtual/jre-1.4
	media-libs/gdk-pixbuf
	>=x11-libs/gtk+-2
	>=media-libs/libart_lgpl-2.1"
DEPEND=">=virtual/jdk-1.4
	jikes? ( dev-java/jikes )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
RESTRICT="nomirror"

S=${WORKDIR}/classpath-${PV}

src_compile() {
	local myjavac="--with-java=`java-config -c`"
	use jikes && myjavac="--with-jikes=/usr/bin/jikes"
	econf \
		--enable-jni \
		--enable-gtk-peer \
		--prefix=/usr/share/${PN}\
		 ${myjavac} || die
	emake || die
}

src_install () {
	einstall || die
}
