A="mtr-0.44.tar.gz"
S=${WORKDIR}/mtr-0.44
DESCRIPTION="Excellent network diagnostic tool.  Augmented traceroute"
SRC_URI="ftp://ftp.bitwizard.nl/mtr/mtr-0.44.tar.gz"
HOMEPAGE="http://www.bitwizard.nl/mtr/"

DEPEND="virtual/glibc 
	>=sys-libs/ncurses-5.2-r2
	gtk? >=gtk+-1.2.10-r3"
        

src_compile() {

    local myconf

    if [ "`use gpm`" ]
    then
      myconf="--without-gtk"
    fi

    ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	 --without-x $myconf || die
    make || die
}

src_install() {

    make prefix=${D}/usr MANDIR=${D}/usr/share/man STRIP=echo install || die
    dodoc README SECURITY TODO AUTHORS COPYING
}
