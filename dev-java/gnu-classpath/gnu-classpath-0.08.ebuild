# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath/gnu-classpath-0.08.ebuild,v 1.1 2004/04/28 01:01:35 karltk Exp $

DESCRIPTION="Free core class libraries for use with virtual machines and compilers for the java programming language"
SRC_URI="ftp://ftp.gnu.org/gnu/classpath/classpath-0.08.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/"
IUSE="doc jikes native"
RDEPEND=">=virtual/jre-1.4
	native? ( media-libs/gdk-pixbuf >=x11-libs/gtk+-2 >=media-libs/libart_lgpl-2.1 )
	"
DEPEND="${DEPEND}
	>=virtual/jdk-1.4
	>=dev-java/jikes-1.19"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

S=${WORKDIR}/classpath-0.08

src_compile() {
	unset CLASSPATH

	local myconf="--with-java=`java-config -c`"
	myconf="--with-jikes"
	if use native ; then
		myconf="${myconf} --enable-jni --enable-gtk-peer  --enable-shared"
	else
		myconf="${myconf} --disable-jni --disable-gtk-peer --disable-shared"
	fi
	use doc && myconf="${myconf} --enable-gjdoc"

	econf \
		--prefix=/usr/share/${PN}\
		 ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
}
