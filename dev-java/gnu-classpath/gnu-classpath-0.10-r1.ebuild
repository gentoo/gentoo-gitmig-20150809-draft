# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath/gnu-classpath-0.10-r1.ebuild,v 1.3 2004/10/20 07:02:47 absinthe Exp $

DESCRIPTION="Free core class libraries for use with virtual machines and compilers for the java programming language"
SRC_URI="ftp://ftp.gnu.org/gnu/classpath/classpath-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/"
IUSE="jikes gtk"
RDEPEND=">=virtual/jre-1.4
	gtk? ( media-libs/gdk-pixbuf >=x11-libs/gtk+-2 >=media-libs/libart_lgpl-2.1 )"
DEPEND=">=virtual/jdk-1.4
	jikes? ( dev-java/jikes )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
RESTRICT="nomirror"
S=${WORKDIR}/classpath-${PV}

src_compile() {
	local myjavac="--with-java=`java-config -c`"
	local myc=""
	use jikes && myjavac="--with-jikes=/usr/bin/jikes"
	use gtk && myc="${myc} --enable-gtk-peer" || myc="${myc} --disable-gtk-peer"
	econf \
		--enable-jni \
		${myc} \
		--prefix=/usr/share/${PN}\
		 ${myjavac} || die
	emake || die
}

src_install () {
	einstall || die
}
