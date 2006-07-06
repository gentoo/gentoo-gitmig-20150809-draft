# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kaffe/kaffe-1.1.4-r1.ebuild,v 1.6 2006/07/06 11:01:41 nelchael Exp $

inherit java flag-o-matic

DESCRIPTION="A cleanroom, open source Java VM and class libraries"
SRC_URI="http://www.kaffe.org/ftp/pub/kaffe/v1.1.x-development/${P/_/-}.tar.gz"
HOMEPAGE="http://www.kaffe.org/"
DEPEND=">=dev-libs/gmp-3.1
		>=media-libs/jpeg-6b
		>=media-libs/libpng-1.2.1
		virtual/x11
		app-arch/zip
		alsa? ( >=media-libs/alsa-lib-1.0.1 )
		esd?  ( >=media-sound/esound-0.2.1 )"
RDEPEND=${DEPEND}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="alsa esd"

src_compile() {
	# see #88330
	strip-flags "-fomit-frame-pointer"

	./configure \
		--prefix=/opt/${P} \
		--host=${CHOST} \
		`use_enable alsa`\
		`use_enable esd`
	# --with-bcel
	# --with-profiling
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	cp ${FILESDIR}/${PF} ${T}/${VMHANDLE} || die
	set_java_env ${T}/${VMHANDLE} || die
}

pkg_postinst() {
	ewarn "Please, do not use Kaffe as your default JDK/JRE!"
	ewarn "Kaffe is currently meant for testing... it should be"
	ewarn "only be used by developers or bug-hunters willing to deal"
	ewarn "with oddities that are bound to come up while using Kaffe!"
}
