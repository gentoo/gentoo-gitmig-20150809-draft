# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jamvm/jamvm-1.2.4.ebuild,v 1.2 2005/04/09 18:57:41 karltk Exp $

inherit eutils

DESCRIPTION="An extremely small and specification-compliant Java virtual machine."
HOMEPAGE="http://jamvm.sourceforge.net/"

SRC_URI="mirror://sourceforge/jamvm/jamvm-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"
DEPEND=">=dev-java/gnu-classpath-0.13"
RDEPEND=">=dev-java/gnu-classpath-0.13"
RESTRICT="nomirror"

src_compile() {
	# compiles JamVM
	cd ${S}
	filter-flags "-fomit-frame-pointer"

	# configure adds "/share/classpath" itself
	myc="--with-classpath-install-dir=/usr"
	use debug && myc="${myc} --enable-tracelock"
	econf ${myc} || die "configure failed."
	emake || die "make failed."
}

src_install() {
	make install-strip DESTDIR=${D} || die "installation failed."

	# puts jni.h in a package dependent folder
	cd ${D}usr/include
	mkdir ${P}
	mv jni.h ${P}
}
