DESCRIPTION="HP OfficeJet Linux driver"
HOMEPAGE="http://hpoj.sourceforge.net/"
SRC_URI="mirror://sourceforge/hpoj/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl scanner qt X snmp cups usb"

DEPEND="qt?      ( >=x11-libs/qt-3.1.0-r1 )
	ssl?     ( >=dev-libs/openssl-0.9.6h )
	scanner? ( >=media-gfx/sane-backends-1.0.9 )
	scanner? ( || ( X? ( >=media-gfx/xsane-0.89 ) >=media-gfx/sane-frontends-1.0.9 ) )
	snmp?    ( >=net-analyzer/ucd-snmp-4.2.6 )
	cups?    ( >=net-print/cups-1.1.18-r2 ) 
	usb?     ( dev-libs/libusb )
        >=net-print/hpijs-1.3.1"
RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
    local myconf
    use snmp \
	&& myconf="${myconf} --with-snmp=/usr" \
	|| myconf="${myconf} --without-snmp"

    use cups \
	&& myconf="${myconf} --with-cups-backend=/usr" \
	|| myconf="${myconf} --without-cups"

    # xojpanel
    use qt \
	&& myconf="${myconf} --with-qt=/usr/qt/3" \
	|| myconf="${myconf} --without-qt"

    use scanner \
	&& myconf="${myconf} --with-sane-packend=/usr" \
	|| myconf="${myconf} --without-sane"

    econf ${myconf} 
#    patch -p0 ${S}/mlcd/Makefile < ${FILESDIR}/mlcd_make.patch
#   patch -p0 ${S}/mlcd/ExMgr.cpp < ${FILESDIR}/ExMgr.cpp_patch
    make || die "compilation failed"
}
## after cups
src_install() {
	cd apps/cmdline
	dobin ptal-print hpojip-test ptal-connect ptal-device ptal-devid ptal-hp ptal-pml
	cd ../../doc
	dohtml *html
	cd ..
	dodoc COPYING LICENSE LICENSE.OpenSSL README
	use qt && dobin apps/xojpanel/xojpanel
	dodir /usr/include
	insinto /usr/include
	doins include/hpojip.h include/ptal.h
	cd lib
	dolib.so hpojip/libhpojip.so*
	dolib.so ptal/libptal.so*
	dodir /usr/lib/sane
	insinto /usr/lib/sane
	doins sane/libsane-hpoj.so*
	dodir /usr/lib/ghostscript/filt \
	/usr/lib/ghostscript/filt/bjc600 \
	/usr/lib/ghostscript/filt/bjc600.1 \
	/usr/lib/ghostscript/filt/bjc600.16 \
	/usr/lib/ghostscript/filt/bjc600.24 \
	/usr/lib/ghostscript/filt/bjc600.24.3 \
	/usr/lib/ghostscript/filt/bjc600.32 \
	/usr/lib/ghostscript/filt/bjc600.8 \
	/usr/lib/ghostscript/filt/bjc600.8.1 \
	/usr/lib/ghostscript/filt/bjt600.32 \
	/usr/lib/ghostscript/filt/direct \
	/usr/lib/ghostscript/filt/gsif \
	/usr/lib/ghostscript/filt/indirect \
	/usr/lib/ghostscript/filt
	cd ..
	dosbin apps/cmdline/ptal-photod apps/cmdline/ptal-printd mlcd/ptal-mlcd scripts/ptal-cups
	exeinto /usr/sbin
	doexe scripts/ptal-init
	dodir /usr/lib/cups/backend
	dosym /usr/sbin/ptal-cups /usr/lib/cups/backend/ptal
	exeinto /etc/init.d
	newexe ${FILESDIR}/hpoj.init hpoj
}

pkg_postinst() {
	echo
	einfo "You might want to emerge  net-print/hpijs too for better quality"
	einfo "or app-admin/mtools for photo-card support."
    echo
	einfo "Before starting hpoj you have to set it up with 'ptal-init setup'"
	echo
}
