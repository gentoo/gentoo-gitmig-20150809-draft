# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/xawtv/xawtv-3.73.ebuild,v 1.3 2002/07/11 06:30:42 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TV application for the bttv driver"
SRC_URI="http://bytesex.org/xawtv/xawtv_3.73.tar.gz
mirror://sourceforge/xaw-deinterlace/xaw-deinterlace-0.0.3.diff.bz2"
HOMEPAGE="http://bytesex.org/xawtv/"
SLOT="0"
DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.1
        >=media-libs/jpeg-6b
        >=media-libs/libpng-1.0.8
        >=x11-base/xfree-4.0.1
        motif? ( x11-libs/openmotif )        aalib? ( media-libs/aalib )
        quicktime? ( media-libs/quicktime4linux )
        alsa? ( media-libs/alsa-lib )"


src_unpack() {

        unpack ${PN}_${PV}.tar.gz
        cd ${S}
        bzcat ${DISTDIR}/xaw-deinterlace-0.0.3.diff.bz2 | patch -p1

}

src_compile() {
        local myconf
        use motif && myconf="--enable-motif" \
                || myconf="--disable-motif"
        use aalib && myconf="$myconf --enable-aa" \
                || myconf="$myconf --disable-aa"
        use quicktime && myconf="$myconf --enable-quicktime" \
                || myconf="$myconf --disable-quicktime"
        use alsa && myconf="$myconf --enable-alsa" \
                || myconf="$myconf --disable-alsa"

        touch src/Xawtv.h src/MoTV.h

        ./configure  --prefix=/usr --host=${CHOST} \
                --disable-lirc \
                --enable-jpeg \
                --enable-xfree-ext \
                --enable-xvideo \
                --with-x $myconf || die

        emake || die
}

src_install() {
        fontdir=${D}/usr/X11R6/lib/X11/fonts/misc
        make install \
                prefix=${D}/usr \
                mandir=${D}/usr/share/man \
                resdir=${D}/etc/X11 \
                fontdir=$fontdir || die
        # remove the bogus fonts.dir so it isn't "owned" by this ebuild
        rm -f $fontdir/fonts.dir

        dodoc COPYING Changes KNOWN_PROBLEMS Miro_gpio.txt
        dodoc Programming-FAQ README* Sound-FAQ TODO
        dodoc Trouble-Shooting UPDATE_TO_v3.0

        insinto /usr/local/httpd/cgi-bin
        insopts -m 755
        doins webcam/webcam.cgi
}

src_postinst() {
        mkfontdir /usr/X11R6/lib/X11/fonts/misc
}

src_postrm() {
        mkfontdir /usr/X11R6/lib/X11/fonts/misc
}
