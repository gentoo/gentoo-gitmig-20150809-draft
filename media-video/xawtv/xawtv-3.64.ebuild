# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# 

S=${WORKDIR}/${P}
DESCRIPTION="TV application for the bttv driver"
SRC_URI="http://bytesex.org/xawtv/xawtv_3.64.tar.gz"
HOMEPAGE="http://bytesex.org/xawtv/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.8
	>=x11-base/xfree-4.0.1
	motif? ( x11-libs/openmotif )
	aalib? ( media-libs/aalib )
	quicktime? ( media-libs/quicktime4linux )"


src_compile() {
	local myconf
	use motif && myconf="--enable-motif" \
		|| myconf="--disable-motif"
	use aalib && myconf="$myconf --enable-aa" \
		|| myconf="$myconf --disable-aa"
	use quicktime && myconf="$myconf --enable-quicktime" \
		|| myconf="$myconf --disable-quicktime"

	touch src/Xawtv.h src/MoTV.h

	./configure  --prefix=/usr --host=${CHOST} \
		--disable-lirc \
		--enable-jpeg \
		--enable-xfree-ext \
		--enable-xvideo \
		--with-x \
		$myconf

	emake || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man \
		resdir=${D}/etc/X11/app-defaults install

	dodoc COPYING Changes KNOWN_PROBLEMS Miro_gpio.txt
	dodoc Programming-FAQ README* Sound-FAQ TODO
	dodoc Trouble-Shooting UPDATE_TO_v3.0

	insinto /usr/local/httpd/cgi-bin
	insopts -m 755
	doins webcam/webcam.cgi
}
