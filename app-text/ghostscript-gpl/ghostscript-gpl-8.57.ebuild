# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-gpl/ghostscript-gpl-8.57.ebuild,v 1.5 2007/08/15 12:24:38 fmccor Exp $

WANT_AUTOMAKE=1.9

inherit autotools elisp-common eutils versionator flag-o-matic

DESCRIPTION="GPL Ghostscript - the most current Ghostscript, AFPL, relicensed"
HOMEPAGE="http://ghostscript.com"

GSDJVU_PV=1.1
CUPS_PV=1.1.23
PVM=$(get_version_component_range 1-2)
SRC_URI="cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200406.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz )
	!bindist? ( djvu? ( mirror://sourceforge/djvu/gsdjvu-${GSDJVU_PV}.tar.gz ) )
	cups? ( mirror://gentoo/cups-${CUPS_PV}-source.tar.bz2 )
	mirror://sourceforge/ghostscript/${P/-gpl}.tar.bz2
	mirror://gentoo/gdevhl12.c.gz"

LICENSE="GPL-2 CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="X bindist cups cjk djvu gtk jpeg2k"

DEP="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( x11-libs/libXt x11-libs/libXext )
	!bindist? ( djvu? ( app-text/djvu ) )
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
	dev-util/pkgconfig"

S=${WORKDIR}/${P/-gpl}

src_unpack() {
	unpack ${A/adobe-cmaps-200406.tar.gz acro5-cmaps-2001.tar.gz}
	if use cjk; then
		cat "${FILESDIR}"/ghostscript-esp-8.15.2-cidfmap.cjk >> ${S}/lib/cidfmap
		cat "${FILESDIR}"/ghostscript-esp-8.15.2-FAPIcidfmap.cjk >> ${S}/lib/FAPIcidfmap
		cd "${S}"/Resource
		unpack adobe-cmaps-200406.tar.gz
		unpack acro5-cmaps-2001.tar.gz
		cd ${WORKDIR}
	fi

	# cups support
	if use cups; then
		cp -r cups-${CUPS_PV}/pstoraster "${S}"
		cd "${S}"/pstoraster
		sed -e 's:@prefix@:/usr:' -e 's:@exec_prefix@:${prefix}:' -e \
			's:@bindir@:${exec_prefix}/bin:' -e 's:@GS@:gs:' \
			pstopxl.in > pstopxl || die "pstopxlsed failed"
		sed -i -e 's:OUTPUTFILE="%stdout" $profile $6$:\0 -:' \
			-e 's:/usr/local:/usr:' pstoraster || die "pstorastersed failed"
		sed -i -e "s:pstopcl6:pstopxl:" cups.mak || die "cupssed failed"
		cd ..
		epatch "${FILESDIR}"/gdevcups.patch
		epatch "${FILESDIR}"/ghostscript-afpl-8.54-cups-destdir.diff

		echo 'include pstoraster/cups.mak' >> src/Makefile.in
		sed -i -e 's:DEVICE_DEVS17=:\0$(DD)cups.dev:' src/Makefile.in || die "sed failed"
		sed -i -e 's:EXTRALIBS=.*:\0 -lcups -lcupsimage:' src/Makefile.in || die "sed failed"
	fi
	cd "${S}"

	if use bindist && use djvu ; then
		ewarn "You have bindist in your USE, djvu support will NOT be compiled!"
		ewarn "See http://djvu.sourceforge.net/gsdjvu/COPYING for details on licensing issues."
	fi

	if ! use bindist && use djvu; then
		unpack gsdjvu-${GSDJVU_PV}.tar.gz
		cp gsdjvu-${GSDJVU_PV}/gsdjvu "${S}"
		cp gsdjvu-${GSDJVU_PV}/gdevdjvu.c "${S}"/src
		epatch "${FILESDIR}"/djvu-gs-gpl.patch
		cp gsdjvu-${GSDJVU_PV}/ps2utf8.ps "${S}"/lib
		cp "${S}"/src/contrib.mak "${S}"/src/contrib.mak.gsdjvu
		grep -q djvusep "${S}"/src/contrib.mak || \
			cat gsdjvu-${GSDJVU_PV}/gsdjvu.mak >> "${S}"/src/contrib.mak
	fi

	epatch "${FILESDIR}"/ghostscript-afpl-8.57-cups-lib.patch
#	epatch "${FILESDIR}"/ghostscript-afpl-8.54-big-cmap-post.patch

	# enable cfax device (bug #56704) and rinkj device
	sed -i -e 's:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev:\0 $(DD)cfax.dev $(DD)rinkj.dev:' \
		"${S}"/src/Makefile.in || die "sed failed"

	# http://www.linuxprinting.org/download/printing/ghostscript-8.x/drivers/hl1250
	# http://bugs.ghostscript.com/show_bug.cgi?id=687484
	cp ${WORKDIR}/gdevhl12.c "${S}"/src/gdevhl12.c || die
	cat "${FILESDIR}"/gdevhl12-hl1250.mak >> "${S}"/src/contrib.mak || die
	sed -e 's#^\(DEVICE_DEVS6=.*\)$#\1 $(DD)hl1240.dev $(DD)hl1250.dev#' \
		-i "${S}"/src/Makefile.in  || die
	sed -i -e "s:#if 1:#if 0:" "${S}"/src/gdevhl12.c || die

	epatch "${FILESDIR}"/ghostscript-afpl-8.54-rinkj.patch

	if ! use gtk; then
		sed -i "s:\$(GSSOX)::" src/*.mak || die "gsx sed failed"
		sed -i "s:.*\$(GSSOX_XENAME)$::" src/*.mak || die "gsxso sed failed"
	fi

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		-e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		-e "s:exdir=.*:exdir=/usr/share/doc/${PF}/examples:" \
		-e "s:docdir=.*:docdir=/usr/share/doc/${PF}/html:" \
		-e "s:GS_DOCDIR=.*:GS_DOCDIR=/usr/share/doc/${PF}/html:" \
		src/Makefile.in src/*.mak || die "sed failed"
}

src_compile() {
	econf $(use_with X x) \
		$(use_with jpeg2k jasper) \
		--with-ijs \
		--with-jbig2dec || die "econf failed"

	if ! use bindist && use djvu; then
		sed -i -e 's!$(DD)bbox.dev!& $(DD)djvumask.dev $(DD)djvusep.dev!g'		Makefile
		sed -i -e 's:(/\(Resource/[a-zA-Z/]*\)):(\1) findlibfile {pop} {pop &}
		ifelse:' lib/gs_res.ps
	fi

	emake -j1 so all || die "emake failed"

	cd ijs
	econf || die "ijs econf failed"
	emake || die "ijs emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
#	emake DESTDIR="${D}" soinstall || die "emake soinstall failed"

	if ! use bindist && use djvu ; then
		dobin gsdjvu
	fi

	rm -fr "${D}"/usr/share/doc/${PF}/html/{README,PUBLIC}
	dodoc doc/README

	cd ${S}/ijs
	emake DESTDIR="${D}" install || die "emake ijs install failed"
}
