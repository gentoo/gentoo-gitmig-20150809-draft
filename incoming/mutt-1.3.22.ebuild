P=mutt-1.3.22
A=mutt-1.3.22i.tar.gz
S=${WORKDIR}/mutt-1.3.22
DESCRIPTION="a small but very powerful text-based mail client"
SRC_URI="ftp://ftp.mutt.org/pub/mutt/${A}"
HOMEPAGE="http://www.mutt.org"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )
        >=sys-libs/ncurses-5.2
	slang? ( >=sys-libs/slang-1.4.2 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
	slang? ( >=sys-libs/slang-1.4.2 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {

    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    if [ "`use ssl`" ] ; then
      myconf="$myconf --with-ssl"
    fi
    if [ "`use slang`" ] ; then
      myconf="$myconf --with-slang"
    fi
    
    try ./configure --prefix=/usr --sysconfdir=/etc/mutt --host=${CHOST} \
	--with-regex  --enable-pop --enable-imap --enable-nfs-fix \
	--with-homespool=Maildir $myconf

    cp doc/Makefile doc/Makefile.orig
    sed 's/README.UPGRADE//' doc/Makefile.orig > doc/Makefile
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    prepman
    dodir /usr/doc/${P}
    mv ${D}/usr/doc/mutt/* ${D}/usr/doc/${P}
    rm -rf ${D}/usr/doc/mutt
    gzip ${D}/usr/doc/${P}/html/*
    gzip ${D}/usr/doc/${P}/samples/*
    gzip ${D}/usr/doc/${P}/*
	insinto /etc/mutt
	doins ${FILESDIR}/Muttrc*
}
