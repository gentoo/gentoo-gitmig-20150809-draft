# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-gnu/ghostscript-gnu-8.55.ebuild,v 1.1 2006/10/21 10:28:25 genstef Exp $

WANT_AUTOMAKE=1.6
inherit autotools elisp-common eutils versionator flag-o-matic

DESCRIPTION="GNU Ghostscript - patched GPL Ghostscript"
HOMEPAGE="http://www.gnu.org/software/ghostscript/"

CUPS_PV=1.1.23
MY_P=gnu-ghostscript-${PV}
PVM=$(get_version_component_range 1-2)
SRC_URI="cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200406.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz )
	cups? ( mirror://gentoo/cups-${CUPS_PV}-source.tar.bz2 )
	ftp://ftp.gnu.org/gnu/ghostscript/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~sparc ~x86 ~x86-fbsd"
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
	!app-text/ghostscript-gpl"

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
	ln -s Makefile.in src/Makefile.in

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
	econf \
		$(use_with X x) \
		$(use_with jpeg2k jasper) \
		--with-ijs \
		--with-jbig2dec \
		|| die "econf failed"
	emake STDDIRS || die "emake failed"

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
