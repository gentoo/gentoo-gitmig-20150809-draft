# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath/gnu-classpath-0.08_rc1.ebuild,v 1.1 2004/04/01 15:20:31 karltk Exp $

DESCRIPTION="Free core class libraries for use with virtual machines and compilers for the java programming language"
SRC_URI="ftp://alpha.gnu.org/gnu/classpath/classpath-0.08-test1.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/"
IUSE="doc jikes"
RDEPEND=">=virtual/jre-1.4
	media-libs/gdk-pixbuf
	>=x11-libs/gtk+-2
	>=media-libs/libart_lgpl-2.1
	"
DEPEND="${DEPEND}
	>=virtual/jdk-1.4
	jikes? ( dev-java/jikes )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

S=${WORKDIR}/classpath-0.08-test1

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
