S=${WORKDIR}/${P}
DESCRIPTION="CVS pserver daemon"
SRC_URI="http://tiefighter.et.tudelft.nl/~arthur/cvsd/${P}.tar.gz"
HOMEPAGE="http://tiefighter.et.tudelft.nl/~arthur/cvsd/"
DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	cd ${S}
    local myconf
	      
     use tcpd && myconf="${myconf} --with-libwrap"

	econf --prefix=/usr ${myconf} || die

	make || die
}

src_install() {                               
	exeinto /usr/sbin
	doexe cvsd cvsd-buildroot cvsd-passwd 
	insinto /etc/cvsd
	mv cvsd.conf-dist cvsd.conf
	doins cvsd.conf
	
	dodoc COPYING* ChangeLog*  FAQ 
	dodoc NEWS README* TODO

	doman cvsd-buildroot.8 cvsd-passwd.8 cvsd.8 cvsd.conf.5
	
	exeinto /etc/init.d ; newexe ${FILESDIR}/cvsd.init cvsd
    insinto /etc/conf.d ; newins ${FILESDIR}/cvsd.confd cvsd

}
pkg_postinst() {
    einfo
    einfo "To configure cvsd please read /usr/share/cvsd-0.9.17/README.gz"
    einfo
}

