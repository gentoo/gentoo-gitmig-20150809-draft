#Copyright 2000 Achim Gottinger
#Distributed under the GPL

P=xawtv-3.17
A=xawtv_3.17.tar.gz
S=${WORKDIR}/${P}
CATEGORY="media-video"
DESCRIPTION="TV application for the bttv driver"
SRC_URI="http://me.in-berlin.de/~kraxel/v4l/"${A}
HOMEPAGE="http://me.in-berlin.de/~kraxel/xawtv.html"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr \
	--enable-jpeg --enable-xfree-ext --enable-xvideo --with-x
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr install
  dodoc COPYING Changes KNOWN_PROBLEMS Miro_gpio.txt Programming-FAQ
  dodoc README* Sound-FAQ TODO Trouble-Shooting UPDATE_TO_v3.0
  insinto /usr/local/httpd/cgi-bin
  insopts -m 755 
  doins webcam/webcam.cgi
}



