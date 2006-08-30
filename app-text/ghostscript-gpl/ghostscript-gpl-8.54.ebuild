# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-gpl/ghostscript-gpl-8.54.ebuild,v 1.2 2006/08/30 23:56:01 genstef Exp $

inherit autotools elisp-common eutils versionator

DESCRIPTION="GPL Ghostscript - the most current Ghostscript, AFPL, relicensed"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/"

CUPS_PV=1.1.23
MY_P=ghostscript-${PV}-gpl
PVM=$(get_version_component_range 1-2)
SRC_URI="cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200406.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz )
	cups? ( mirror://gentoo/cups-${CUPS_PV}-source.tar.bz2 )
	mirror://sourceforge/ghostscript/${MY_P}.tar.bz2
	mirror://gentoo/gdevhl12.c.gz"

LICENSE="GPL-2"
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
	unpack ${A/adobe-cmaps-200406.tar.gz acro5-cmaps-2001.tar.gz}
	if use cjk; then
		cat ${FILESDIR}/ghostscript-esp-8.15.2-cidfmap.cjk >> ${S}/lib/cidfmap
		cat ${FILESDIR}/ghostscript-esp-8.15.2-FAPIcidfmap.cjk >> ${S}/lib/FAPIcidfmap
		cd ${S}/Resource
		unpack adobe-cmaps-200406.tar.gz
		unpack acro5-cmaps-2001.tar.gz
		cd ${WORKDIR}
	fi

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
		epatch ${FILESDIR}/ghostscript-afpl-8.54-cups-destdir.diff

		echo 'include pstoraster/cups.mak' >> src/Makefile.in
		sed -i -e 's:DEVICE_DEVS17=:\0$(DD)cups.dev:' src/Makefile.in || die "sed failed"
		sed -i -e 's:EXTRALIBS=.*:\0 -lcups -lcupsimage:' src/Makefile.in || die "sed failed"
	fi
	cd ${S}
	epatch ${FILESDIR}/ghostscript-afpl-8.54-cups-lib.patch
	epatch ${FILESDIR}/ghostscript-afpl-8.54-big-cmap-post.patch

	# enable cfax device (bug #56704) and rinkj device
	sed -i -e 's:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev:\0 $(DD)cfax.dev $(DD)rinkj.dev:' ${S}/src/Makefile.in || die "sed failed"

	# http://www.linuxprinting.org/download/printing/ghostscript-8.x/drivers/hl1250
	# http://bugs.ghostscript.com/show_bug.cgi?id=687484
	cp ${WORKDIR}/gdevhl12.c ${S}/src/gdevhl12.c || die
	cat ${FILESDIR}/gdevhl12-hl1250.mak >> ${S}/src/contrib.mak || die
	sed -e 's#^\(DEVICE_DEVS6=.*\)$#\1 $(DD)hl1240.dev $(DD)hl1250.dev#' \
		-i "${S}"/src/Makefile.in  || die
	sed -i -e "s:#if 1:#if 0:" "${S}"/src/gdevhl12.c || die

	# #128650, #128645, http://bugs.ghostscript.com/show_bug.cgi?id=688703
	epatch ${FILESDIR}/ghostscript-afpl-8.54-ps2epsi-afpl.diff
	epatch ${FILESDIR}/ghostscript-afpl-8.54-rinkj.patch
	epatch ${FILESDIR}/ghostscript-afpl-8.54-destdir.diff

	# already fixed inSVN, http://bugs.ghostscript.com/show_bug.cgi?id=688702
	epatch ${FILESDIR}/ghostscript-afpl-8.54-gtk2.patch
	if ! use gtk; then
		sed -i "s:\$(GSSOX)::" src/*.mak || die "gsx sed failed"
		sed -i "s:.*\$(GSSOX_XENAME)$::" src/*.mak || die "gsxso sed failed"
	fi

	# fixed inSVN http://bugs.ghostscript.com/show_bug.cgi?id=688721
	epatch ${FILESDIR}/ghostscript-afpl-8.54-segfault.patch

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		src/Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		src/Makefile.in || die "sed failed"
	sed -i -e "s:exdir=.*:exdir=/usr/share/doc/${PF}/examples:" \
		src/Makefile.in || die "sed failed"
	sed -i -e "s:docdir=.*:docdir=/usr/share/doc/${PF}/html:" \
		-e "s:GS_DOCDIR=.*:GS_DOCDIR=/usr/share/doc/${PF}/html:" \
		src/Makefile.in src/*.mak || die "sed failed"
}

src_compile() {
	econf $(use_with X x) \
		$(use_with jpeg2k jasper) \
		--with-ijs \
		--with-jbig2dec || die "econf failed"
	emake STDDIRS so all || die "emake failed"

	cd ijs
	econf || die "ijs econf failed"
	emake || die "ijs emake failed"
}

src_install() {
	emake DESTDIR="${D}" install soinstall || die "emake install failed"

	rm -fr ${D}/usr/share/doc/${PF}/html/{README,PUBLIC}
	dodoc doc/README
	use emacs && elisp-site-file-install doc/gsdoc.el

	cd ${S}/ijs
	emake DESTDIR="${D}" install || die "emake ijs install failed"
}
