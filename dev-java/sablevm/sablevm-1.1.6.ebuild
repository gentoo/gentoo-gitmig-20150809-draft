# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sablevm/sablevm-1.1.6.ebuild,v 1.2 2004/07/14 02:52:10 agriffis Exp $

DESCRIPTION="A robust, clean, extremely portable, efficient, and specification-compliant Java virtual machine."
HOMEPAGE="http://sablevm.org/"

# karltk: According to Grzegorz Prokopski (gadek), the two tarfiles will merge
# into one in the future. For now, they consistently make concurrent releases,
# so I merged them into one ebuild.

SRC_URI="http://sablevm.org/download/release/${PV}/sablevm-${PV}.tar.gz
	http://sablevm.org/download/release/${PV}/sablevm-classpath-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk debug"
DEPEND=">=dev-libs/libffi-1.20
	>=dev-java/jikes-1.19
	gtk? (
		>=x11-libs/gtk+-2.2
		>=media-libs/libart_lgpl-2.1
		>=media-libs/gdk-pixbuf-0.22
	)"
#RDEPEND=""

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_compile() {

	# Compile the Classpath

	cd ${S}/sablevm-classpath-${PV}
	local myc="--with-jikes"
	use gtk && myc="${myc} --enable-gtk-peer" || myc="${myc} --disable-gtk-peer"
	econf ${myc} || die
	emake || die "emake failed"

	# Compile the VM
	cd ${S}/sablevm-${PV}
	myc=""
	use debug && myc="${myc} --enable-debugging-features" || myc="${myc} --disable-debugging-features"
	econf ${myc} || die
	emake || die "emake failed"
}

src_install() {

	# Install the Classpath

	cd ${S}/sablevm-classpath-${PV}
	einstall || die

	# Install the VM

	cd ${S}/sablevm-${PV}
	einstall || die

	mv ${D}/usr/share/sablevm-classpath ${D}/usr/share/sablevm/ || \
		die "Path fixup failed!"
}
