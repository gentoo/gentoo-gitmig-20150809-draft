# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-cvs/jack-cvs-0.7-r2.ebuild,v 1.3 2003/09/11 01:21:31 msterret Exp $

IUSE="doc jack-tmpfs debug"

inherit cvs
inherit flag-o-matic

DESCRIPTION="A low-latency audio server - cvs version"
HOMEPAGE="http://jackit.sourceforge.net/"

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/jackit"
ECVS_MODULE="jack"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/jackit"

SRC_URI=""

# libjack is LGPL, the rest is GPL
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"

DEPEND="$DEPEND
	>=media-libs/alsa-lib-0.9.1
	>=media-libs/libsndfile-1.0.0
	dev-libs/glib
	dev-util/pkgconfig
	sys-libs/ncurses
	doc? ( app-doc/doxygen )
	!media-sound/jack-audio-connection-kit"

PROVIDE="virtual/jack"

S="${WORKDIR}/${PN/-cvs/}"

src_compile() {
	export WANT_AUTOCONF_2_5=1
	sh autogen.sh

	local myconf
	local myarch

	myarch=`get-flag -march`

	cd $S
	sed -i "s/^CFLAGS=\$JACK_CFLAGS/CFLAGS=\"\$JACK_CFLAGS $myarch\"/" configure

	use doc \
		&& myconf="--with-html-dir=/usr/share/doc/${PF}/html" \
		|| myconf="--without-html-dir"

	use jack-tmpfs && myconf="${myconf} --with-default-tmpdir=/dev/shm"
	use debug && myconf="${myconf} --enable-debug"

	myconf="${myconf} --enable-optimize --with-gnu-ld"

	econf ${myconf} || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {

	use doc && dodir /usr/share/doc/${PF}/html

	make DESTDIR=${D} \
		datadir=${D}/usr/share \
		install || die

	use doc && mv \
		${D}/usr/share/jack-audio-connection-kit/reference/html/* \
		${D}/usr/share/doc/${PF}/html

	use doc && rm -rf ${D}/usr/share/jack-audio-connection-kit
}

pkg_postinst() {

	einfo ""
	einfo "Remember to re-emerge jack-cvs before re-emerging ardour-cvs"
	einfo ""
}
