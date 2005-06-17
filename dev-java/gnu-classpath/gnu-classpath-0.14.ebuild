# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath/gnu-classpath-0.14.ebuild,v 1.3 2005/06/17 17:30:24 luckyduck Exp $

DESCRIPTION="Free core class libraries for use with virtual machines and compilers for the java programming language"
SRC_URI="ftp://ftp.gnu.org/gnu/classpath/classpath-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="x86 ~sparc ppc amd64"
IUSE="jikes gtk xml2"

DEPEND=">=virtual/jdk-1.4
	app-arch/zip
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
	gtk? (
		media-libs/gdk-pixbuf
		>=x11-libs/gtk+-2
		>=media-libs/libart_lgpl-2.1
	)
	xml2? ( >=dev-libs/libxml2-2.6.8 >=dev-libs/libxslt-1.1.11 )"

S=${WORKDIR}/classpath-${PV}

src_compile() {
	local myjavac="--with-java=`java-config -c`"
	local myc=""
	use jikes && myjavac="--with-jikes=/usr/bin/jikes"
	use gtk && myc="${myc} --enable-gtk-peer" || myc="${myc} --disable-gtk-peer"
	use xml2 && myc="${myc} --enable-xmlj"

	econf \
		--enable-jni \
		${myc} \
		--prefix=/usr/share/${PN}\
		 ${myjavac} || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "make install failed"
}
