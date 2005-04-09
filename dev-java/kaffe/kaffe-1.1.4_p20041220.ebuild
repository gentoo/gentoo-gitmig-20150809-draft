# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kaffe/kaffe-1.1.4_p20041220.ebuild,v 1.2 2005/04/09 20:24:19 luckyduck Exp $

inherit java

date=${PV/*_p/}
DESCRIPTION="A cleanroom, open source Java VM and class libraries"
SRC_URI="http://dev.gentoo.org/~karltk/projects/java/distfiles/kaffe-${date}-gentoo.tar.gz"
HOMEPAGE="http://www.kaffe.org/"
DEPEND=">=dev-libs/gmp-3.1
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	virtual/libc
	virtual/x11
	>=dev-java/java-config-0.2.4
	dev-java/jikes"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa esd"

PROVIDE="virtual/jdk-1.4
	virtual/jre-1.4
	virtual/java-scheme-2"
S=${WORKDIR}/kaffe-${date}

src_compile() {
	./configure \
		--prefix=/opt/${P} \
		--host=${CHOST} \
		`use_enable alsa`\
		`use_enable esd` \
		--with-jikes || die "Failed to configure"
	# --with-bcel
	# --with-profiling
	make || die "Failed to compile"
}

src_install () {
	make DESTDIR=${D} install || die "Failed to install"
	set_java_env ${FILESDIR}/${VMHANDLE} || die "Failed to install environment files"
}

pkg_postinst() {
	ewarn "By all means, do not use Kaffe as your default JDK/JRE!"
	ewarn "Kaffe is currently meant for testing... it should be"
	ewarn "only be used by developers or bug-hunters willing to deal"
	ewarn "with oddities that are bound to come up while using Kaffe!"
}
