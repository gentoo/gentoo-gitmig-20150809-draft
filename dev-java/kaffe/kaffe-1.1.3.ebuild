# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kaffe/kaffe-1.1.3.ebuild,v 1.1 2004/01/09 09:23:46 karltk Exp $

inherit java

S=${WORKDIR}/${P/_/-}
DESCRIPTION="A cleanroom, open source Java VM and class libraries"
SRC_URI="http://www.kaffe.org/ftp/pub/kaffe/v1.1.x-development/${P/_/-}.tar.gz"
HOMEPAGE="http://www.kaffe.org/"
DEPEND=">=dev-libs/gmp-3.1
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	virtual/glibc
	virtual/x11
	>=dev-java/java-config-0.2.4"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
}

src_compile() {
	./configure \
		--prefix=/opt/${P} \
		--host=${CHOST} \
		`use_enable alsa`\
		`use_enable esd`
	# --with-bcel
	# --with-profiling
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}
