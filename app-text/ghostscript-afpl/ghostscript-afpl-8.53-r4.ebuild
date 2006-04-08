# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-afpl/ghostscript-afpl-8.53-r4.ebuild,v 1.4 2006/04/08 20:50:50 halcy0n Exp $

inherit eutils

DESCRIPTION="AFPL Ghostscript"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/"

CUPS_PV=1.1.23
MY_P=ghostscript-${PV}
PVM=${PV%.[0-9]}
SRC_URI="mirror://sourceforge/ghostscript/${MY_P}.tar.gz
	cups? ( mirror://gentoo/cups-${CUPS_PV}-source.tar.bz2 )
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz )
	mirror://gentoo/gdevhl12.c.gz"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X cups cjk emacs gtk jpeg2k"


DEP="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( || ( x11-libs/libXt virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( >=net-print/cups-1.1.20 )
	jpeg2k? ( media-libs/jasper )
	!app-text/ghostscript-esp
	!app-text/ghostscript-gnu"

RDEPEND="${DEP}
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	media-fonts/gnu-gs-fonts-std"

DEPEND="${DEP}
	gtk? ( dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A/adobe-cmaps-200204.tar.gz acro5-cmaps-2001.tar.gz}

	# cups support
	if use cups; then
		cp -r cups-${CUPS_PV}/pstoraster ${S}
		cd ${S}/pstoraster
		sed -e 's:@prefix@:/usr:' -e 's:@exec_prefix@:${prefix}:' -e \
			's:@bindir@:${exec_prefix}/bin:' -e 's:@GS@:gs:' \
			pstopxl.in > pstopxl || die "pstopxlsed failed"
		sed -i -e 's:OUTPUTFILE="%stdout" $profile $6$:\0 -:' \
			-e 's:/usr/local:/usr:' pstoraster || die "pstorastersed failed"
		sed -i -e "s:pstopcl6:pstopxl:" cups.mak || die "cupssed failed"
		cd ..
		epatch ${FILESDIR}/gdevcups.patch
	fi

	# enable cfax device (bug #56704)
	sed -i -e 's:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev $(DD)cfax.dev:' ${S}/Makefile.in || die "sed failed"
	cd ${S}
	epatch "${FILESDIR}"/gs852-lib.patch
	# see bug #111537
	use amd64 || epatch "${FILESDIR}"/rinkj.patch

	# http://www.linuxprinting.org/download/printing/ghostscript-8.x/drivers/hl1250
	cp ${WORKDIR}/gdevhl12.c ${S}/src/gdevhl12.c || die
	cat ${FILESDIR}/gdevhl12-hl1250.mak >> ${S}/src/contrib.mak || die
	sed 's#^\(DEVICE_DEVS6=.*\)$#\1 $(DD)hl1240.dev $(DD)hl1250.dev#' \
		-i "${S}"/Makefile.in "${S}"/src/Makefile.in  || die
	sed -i "s:#if 1:#if 0:" "${S}"/src/gdevhl12.c || die

	# bug 121383 - gxccman.c assertion failed
	epatch ${FILESDIR}/${PN}-8.53-assertionfailed.patch

	epatch ${FILESDIR}/../../ghostscript-esp/files/ghostscript-gtk2.patch
	if ! use gtk; then
		sed -i "s:\$(GSSOX)::" src/*.mak || die "gsx sed failed"
		sed -i "s:.*\$(GSSOX_XENAME)$::" src/*.mak || die "gsxso sed failed"
	fi

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		Makefile.in || die "sed failed"
	sed -i -e "s:\$(gsdatadir)/Resource:/usr/share/ghostscript/${PVM}/Resource:" \
		Makefile.in || die "sed failed"

	# #128650, #128645
	epatch ${FILESDIR}/${P}-ps2epsi-afpl.diff
	sed -i "s/Id:.*//" pstoraster/pstoraster.convs
}

src_compile() {
	local myconf
	myconf="--with-ijs --with-jbig2dec"

	econf $(use_with X x) \
		$(use_with jpeg2k jasper) \
		${myconf} || die "econf failed"

	if use cups; then
		echo 'include pstoraster/cups.mak' >> Makefile
		sed -i -e 's:DEVICE_DEVS17=:DEVICE_DEVS17=$(DD)cups.dev:' Makefile || die "sed failed"
		sed -i -e 's:EXTRALIBS=\(.*\):EXTRALIBS=\1 -lcups -lcupsimage:' Makefile || die "sed failed"
	fi
	emake -j1 || die "make failed"
	emake so -j1 || die "make failed"

	cd ijs
	./autogen.sh
	econf || die "econf failed"
	emake -j1 || die "make failed"
	cd ..
}

src_install() {
	einstall D=/ install_prefix=${D} soinstall

	rm -fr ${D}/usr/share/ghostscript/${PVM}/doc || die
	dodoc doc/README
	dohtml doc/*.html doc/*.htm

	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins doc/gsdoc.el
	fi

	if use cjk; then
		dodir /usr/share/ghostscript/Resource
		dodir /usr/share/ghostscript/Resource/Font
		dodir /usr/share/ghostscript/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	# install ijs
	cd ${S}/ijs
	make DESTDIR="${D}" install || die "ijs install failed"
}
