# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath/gnu-classpath-0.06.ebuild,v 1.2 2004/03/22 19:59:35 dholm Exp $

DESCRIPTION="Free core class libraries for use with virtual machines and compilers for the java programming language"
SRC_URI="ftp://alpha.gnu.org/gnu/classpath/${P/gnu-}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
		media-libs/gdk-pixbuf
		virtual/glibc
		>=x11-libs/gtk+-2
		>=media-libs/libart_lgpl-2.1
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.4"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

S=${WORKDIR}/${P/gnu-}

src_compile() {
	local myjavac="--with-java=`java-config -c`"
	use jikes && myjavac="--with-jikes=/usr/bin/jikes"
	econf --enable-jni --enable-gtk-peer --prefix=/usr/share/${PN} ${myjavac}
	emake
}

src_install () {
	einstall
}
