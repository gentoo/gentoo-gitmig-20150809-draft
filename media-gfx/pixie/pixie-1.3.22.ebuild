# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixie/pixie-1.3.22.ebuild,v 1.1 2004/10/22 21:47:10 eradicator Exp $

inherit eutils

IUSE="X"

MY_PN="Pixie"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="RenderMan like photorealistic renderer."
HOMEPAGE="http://pixie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-src-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc -amd64"

RDEPEND="media-libs/jpeg
	 sys-libs/zlib
	 media-libs/tiff
	 X? ( virtual/x11 )"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.8"

src_unpack() {
	unpack ${A}

	cd ${S}
	# These have been sent upstream, and rejected, but this is the
	# "right way" -- eradicator
	epatch ${FILESDIR}/${PN}-1.3.11-math.patch

	# Gentoo-specific stuff to fix the build/install process
	epatch ${FILESDIR}/${PN}-1.3.11-gentoo.patch

	# redirecting aclocal to /dev/null because there are alot of warnings
	# output for deprecated stuff in 1.8.5
	WANT_AUTOMAKE=1.8 aclocal >& /dev/null
	WANT_AUTOMAKE=1.8 automake
	WANT_AUTOCONF=2.5 autoconf
}

src_compile() {
	./configure --prefix=/opt/pixie || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog DEVNOTES NEWS README

	insinto /etc/env.d
	doins ${FILESDIR}/50pixie

	edos2unix ${D}/opt/pixie/shaders/*

	mv ${D}/opt/pixie/doc ${D}/usr/share/doc/${PF}/html
}
