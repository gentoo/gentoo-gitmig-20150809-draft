# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.71.2-r1.ebuild,v 1.1 2003/05/31 12:07:45 jje Exp $

IUSE="doc jack-tmpfs"

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-libs/glib
	>=media-libs/alsa-lib-0.9.0_rc6
	>=media-libs/libsndfile-1.0.0
	!media-sound/jack-cvs
	doc? ( app-doc/doxygen )"

PROVIDE="virtual/jack"

src_compile() {
	local myconf
	use doc \
		&& myconf="--with-html-dir=/usr/share/doc/${PF}/html" \
		|| myconf="--without-html-dir"

	use jack-tmpfs && myconf="${myconf} --with-default-tmpdir=/dev/shm"

	econf ${myconf} || die "configure failed"
	emake || die "compilation failed"
}

src_install() {

        use doc && dodir /usr/share/doc/${PF}/html

        make \
                DESTDIR=${D} \
                datadir=${D}/usr/share \
                install || die

        use doc && mv \
                ${D}/usr/share/jack-audio-connection-kit/reference/html/* \
                ${D}/usr/share/doc/${PF}/html
        use doc && rm -rf ${D}/usr/share/jack-audio-connection-kit
}
