# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixie/pixie-1.4.1.ebuild,v 1.2 2005/04/09 04:27:00 eradicator Exp $

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
	sys-devel/libtool
	>=sys-devel/automake-1.8"

src_unpack() {
	unpack ${A}

	cd ${S}
	# These have been sent upstream, and rejected, but this is the
	# "right way" -- eradicator
	epatch ${FILESDIR}/${PN}-1.3.11-math.patch

	# Gentoo-specific stuff to fix the build/install process
	epatch ${FILESDIR}/${PN}-1.4.1-libtool.patch

	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	libtoolize --force --copy || die
	aclocal || die
	automake -a -f -c || die
	autoconf || die
}

src_compile() {
	econf --disable-static || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog DEVNOTES NEWS README

	edos2unix ${D}/usr/share/pixie/shaders/*
	mv ${D}/usr/share/pixie/doc ${D}/usr/share/doc/${PF}/html
}
