# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-gnu/ghostscript-gnu-8.16-r3.ebuild,v 1.1 2006/04/27 22:59:37 flameeyes Exp $

inherit eutils libtool autotools

DESCRIPTION="GNU Ghostscript"
HOMEPAGE="http://www.gnu.org/software/ghostscript/"

CUPS_PV=1.1.23
MY_P=gnu-ghostscript-${PV}
PVM=${PV%.[0-9]}
SRC_URI="ftp://ftp.gnu.org/gnu/ghostscript/${MY_P}.tar.gz
	cups? ( mirror://gentoo/cups-${CUPS_PV}-source.tar.bz2 )
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="X cups cjk emacs gtk"


DEP=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( || ( x11-libs/libXt virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( >=net-print/cups-1.1.20 )
	!app-text/ghostscript-afpl
	!app-text/ghostscript-esp"

RDEPEND="${DEP}
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	media-fonts/gnu-gs-fonts-std"

DEPEND="${DEP}
	gtk? ( dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz

	# cups support
	if use cups; then
		unpack cups-${CUPS_PV}-source.tar.bz2
		cp -r cups-${CUPS_PV}/pstoraster ${S}
		cd ${S}/pstoraster
		sed -e 's:@prefix@:/usr:' -e 's:@exec_prefix@:${prefix}:' \
			-e 's:@bindir@:${exec_prefix}/bin:' -e 's:@GS@:gs:' \
			pstopxl.in > pstopxl || die "pstopxlsed failed"
		sed -i -e 's:OUTPUTFILE="%stdout" $profile $6$:\0 -:' \
			-e 's:/usr/local:/usr:' pstoraster || die "pstorastersed failed"
		sed -i -e "s:pstopcl6:pstopxl:" cups.mak || die "cupssed failed"
		cd ..
		epatch pstoraster/gs811-lib.patch
	fi

	# enable cfax device (bug #56704)
	sed -i -e 's:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev $(DD)cfax.dev:' \
		${S}/src/Makefile.in || die "sed failed"
	cd ${S}

	#epatch ${FILESDIR}/gs-${PV}destdir.patch
	#epatch ${FILESDIR}/ghostscript-build.patch
	#epatch ${FILESDIR}/ghostscript-scripts.patch
	#epatch ${FILESDIR}/ghostscript-ps2epsi.patch
	epatch ${FILESDIR}/../../ghostscript-esp/files/ghostscript-badc.patch
	epatch ${FILESDIR}/../../ghostscript-esp/files/ghostscript-pagesize.patch
	epatch ${FILESDIR}/../../ghostscript-esp/files/ghostscript-noopt.patch
	epatch ${FILESDIR}/../../ghostscript-esp/files/ghostscript-use-external-freetype.patch
	#epatch ${FILESDIR}/ghostscript-split-font-configuration.patch

	# not submitted
	epatch ${FILESDIR}/../../ghostscript-esp/files/ijs-dirinstall.diff
	epatch ${FILESDIR}/../../ghostscript-esp/files/ghostscript-gtk2.patch
	if ! use gtk; then
		sed -i "s:\$(GSSOX)::" src/*.mak || die "gsx sed failed"
		sed -i "s:.*\$(GSSOX_XENAME)$::" src/*.mak || die "gsxso sed failed"
	fi

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		src/Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		src/Makefile.in || die "sed failed"

	epatch "${FILESDIR}/ghostscript-fontconfig.patch"

	sed -i -e '/^AC_INIT$/d; /AM_/d' "${S}/src/configure.ac"

	cp /usr/share/automake-1.9/install-sh "${S}"
	eautoreconf

	elibtoolize
}

src_compile() {
	local myconf
	myconf="--with-ijs --with-jbig2dec"

	econf $(use_with X x) \
		${myconf} || die "econf failed"

	if use cups; then
		echo 'include pstoraster/cups.mak' >> Makefile
		sed -i -e 's:DEVICE_DEVS17=:DEVICE_DEVS17=$(DD)cups.dev:' Makefile || die "sed failed"
		sed -i -e 's:EXTRALIBS=\(.*\):EXTRALIBS=\1 -lcups -lcupsimage:' Makefile || die "sed failed"
	fi
	emake -j1 || die "make failed"
	emake so -j1 || die "make failed"

	cd ijs
	libtoolize --copy --force
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
