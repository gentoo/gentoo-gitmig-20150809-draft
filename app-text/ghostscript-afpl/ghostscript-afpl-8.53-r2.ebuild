# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-afpl/ghostscript-afpl-8.53-r2.ebuild,v 1.2 2006/02/21 21:29:48 vanquirius Exp $

inherit eutils

DESCRIPTION="AFPL Ghostscript"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/"

MY_PN="ghostscript"
MY_P="${MY_PN}-${PV}"
CUPS_PV=1.1.23

SRC_URI="mirror://sourceforge/ghostscript/${MY_P}.tar.gz
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz )
	cups? ( mirror://gentoo/cups-${CUPS_PV}-source.tar.bz2 )
	mirror://gentoo/gdevhl12.c.gz"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="X cups cjk gtk jpeg2k"

PROVIDE="virtual/ghostscript"

DEPEND="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.8
	>=sys-libs/zlib-1.2.1
	>=media-fonts/gnu-gs-fonts-std-8.11
	X? (  || ( ( x11-libs/libXt
				x11-libs/libXpm
			)
			virtual/x11
		)
	)
	gtk? ( =x11-libs/gtk+-1.2* )
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	cups? ( net-print/cups )
	jpeg2k? ( media-libs/jasper )
	!virtual/ghostscript"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ghostscript-${PV}.tar.gz
	unpack gdevhl12.c.gz

	# cups support
	if use cups; then
		unpack cups-${CUPS_PV}-source.tar.bz2
		cp -r cups-${CUPS_PV}/pstoraster "${S}"
		cd "${S}"/pstoraster
		sed -e 's:@prefix@:/usr:' -e 's:@exec_prefix@:${prefix}:' -e 's:@bindir@:${exec_prefix}/bin:' -e 's:@GS@:gs:' pstopxl.in > pstopxl
		sed -i -e 's:/usr/local:/usr:' pstoraster
		#81418
		sed -i 's:OUTPUTFILE="%stdout" $profile $6$:OUTPUTFILE="%stdout" $profile $6 -:' pstoraster
		sed -i -e "s:pstopcl6:pstopxl:" cups.mak
		cd "${S}"
		epatch "${FILESDIR}"/gdevcups.patch
	fi

	cd "${S}"
	epatch "${FILESDIR}"/gs852-lib.patch
	# see bug #111537
	use amd64 || epatch "${FILESDIR}"/rinkj.patch

	# enable cfax device (bug #56704)
	sed -i -e 's:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev $(DD)cfax.dev:' ${S}/Makefile.in

	# Brother HL-12XX support
	cp "${WORKDIR}"/gdevhl12.c "${S}"/src/gdevhl12.c || die
	cat "${FILESDIR}"/gdevhl12-hl1250.mak >> "${S}"/src/devs.mak || die
	sed 's#^\(DEVICE_DEVS6=.*\)$#\1 $(DD)hl1240.dev $(DD)hl1250.dev#' \
		-i "${S}"/src/Makefile.in || die

	# bug 121383 - gxccman.c assertion failed
	epatch "${FILESDIR}"/${PN}-8.53-assertionfailed.patch
}

src_compile() {
	# don't build gtk frontend if not in use
	use gtk || sed -i -e 's:$(INSTALL_PROGRAM) $(GSSOX):#:' src/unix-dll.mak \
		-e 's:$(GSSOX)::' src/unix-dll.mak

	econf \
		$(use_with X x) \
		$(use_with jpeg2k jasper) \
		|| die "econf failed"
#		$(use_with ijs) \
#		$(use_with jbig2dec) \

	# build cups driver with cups
	if use cups; then
		echo 'include pstoraster/cups.mak' >> Makefile
		sed -i -e 's:DEVICE_DEVS17=:DEVICE_DEVS17=$(DD)cups.dev:' Makefile
		sed -i -e 's:LDFLAGS=\(.*\)$(XLDFLAGS):LDFLAGS=\1-L/usr/include -lcups -lcupsimage $(XLDFLAGS):' Makefile
	fi

	# search path fix
	sed -i -e "s:\$(gsdatadir)/lib:/usr/share/ghostscript/${PV}/lib:" Makefile
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' Makefile
	sed -i -e "s:\$(gsdatadir)/Resource:/usr/share/ghostscript/${PV}/Resource:" Makefile

	emake || die "emake failed"
	emake so || die "emake so failed"

	# build ijs
	cd ijs
	./autogen.sh
	econf || die "econf failed"
	emake || die "emake failed"
	cd ..
}

src_install() {
	einstall D=/ install_prefix=${D} soinstall

	rm -fr ${D}/usr/share/ghostscript/${PV}/doc || die
	dodoc doc/README
	dohtml doc/*.html doc/*.htm
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el || die

	if use cjk ; then
		dodir /usr/share/ghostscript/Resource
		dodir /usr/share/ghostscript/Resource/Font
		dodir /usr/share/ghostscript/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	# install ijs
	cd ${S}/ijs
	dodir /usr/bin /usr/include /usr/lib
	einstall D=/ install_prefix=${D}
}
