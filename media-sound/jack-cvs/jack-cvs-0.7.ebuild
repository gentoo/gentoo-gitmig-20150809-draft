# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-cvs/jack-cvs-0.7.ebuild,v 1.2 2003/05/15 11:33:02 jje Exp $

IUSE="doc"

inherit cvs            

DESCRIPTION="A low-latency audio server - cvs version"
HOMEPAGE="http://jackit.sourceforge.net/"

ECVS_SERVER="cvs.jackit.sourceforge.net:/cvsroot/jackit"
ECVS_MODULE="jack"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/jackit" 

SRC_URI=""

# libjack is LGPL, the rest is GPL
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"

DEPEND="$DEPEND 
        dev-libs/glib
	>=media-libs/alsa-lib-0.9.0_rc6
	>=media-libs/libsndfile-1.0.0
	!media-sound/jack-audio-connection-kit
	doc? ( app-doc/doxygen )"
PROVIDE="virtual/jack"

S="${WORKDIR}/${PN/-cvs/}"

src_compile() {
	export LDFLAGS="-L/usr/lib/fltk-1.1"                                   	       
	export CPPFLAGS="-I/usr/include/fltk-1.1"
	export WANT_AUTOCONF_2_5=1
	sh autogen.sh

	local myconf
	use doc \
		&& myconf="--with-html-dir=/usr/share/doc/${PF}/html" \
		|| myconf="--without-html-dir"

	econf ${myconf} || die "configure failed"
	emake || die "parallel make failed"
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

pkg_postinst() {

	einfo ""
	einfo "Remember to re-emerge jack-cvs before re-emerging ardour-cvs"
	einfo ""
}
