# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ptex/ptex-3.1.2-r1.ebuild,v 1.7 2003/12/22 15:46:47 usata Exp $

inherit eutils flag-o-matic
filter-flags "-fstack-protector"

IUSE="X"

PTEX_TEXMF_PV=2.1
TETEX_PV=2.0.2
TETEX_TEXMF_PV=2.0.2

S=${WORKDIR}/tetex-src-${TETEX_PV}
PTEX_SRC="ptex-src-${PV}.tar.gz"
PTEX_TEXMF="ptex-texmf-${PTEX_TEXMF_PV}.tar.gz"
TETEX_SRC="tetex-src-${TETEX_PV}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_TEXMF_PV}.tar.gz"

DESCRIPTION="The ASCII publishing TeX distribution"
SRC_PATH_PTEX=ftp://ftp.ascii.co.jp/pub/TeX/ascii-ptex
SRC_PATH_TETEX=ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/2.0/distrib
SRC_URI="${SRC_PATH_PTEX}/tetex/${PTEX_SRC}
	${SRC_PATH_PTEX}/tetex/${PTEX_TEXMF}
	${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	${SRC_PATH_PTEX}/dvips/dvipsk-jpatch-p1.6.tar.gz"
HOMEPAGE="http://www.ascii.co.jp/pb/ptex/"

KEYWORDS="x86 alpha ppc sparc ~amd64"
SLOT="0"
LICENSE="GPL-2 BSD"

DEPEND="!app-text/tetex
	!app-text/cstetex
	sys-apps/ed
	sys-libs/zlib
	X? ( virtual/x11 )
	>=media-libs/libpng-1.2.1
	sys-libs/ncurses
	>=net-libs/libwww-5.3.2-r1"
RDEPEND="${DEPEND}
	>=dev-lang/perl-5.2
	dev-util/dialog"
PDEPEND="app-text/xdvik"
PROVIDE="virtual/tetex"

src_unpack() {

	unpack ${TETEX_SRC}

	mkdir ${S}/texmf; cd ${S}/texmf
	unpack ${TETEX_TEXMF}
	unpack ${PTEX_TEXMF}

	cd ${S}/texk/web2c
	unpack ${PTEX_SRC}

	cd ${S}/texk
	unpack dvipsk-jpatch-p1.6.tar.gz
	epatch dvipsk-5.92b-p1.6.patch

	cd ${S}
	epatch ${FILESDIR}/tetex-2.0.2-dont-run-config.diff
	epatch ${FILESDIR}/tetex-2.0.2.diff

	# listings.sty is accidently in the wrong place in version 2.0.2
	mv texmf/source/latex/listings/listings.sty texmf/tex/latex/listings
}

src_compile() {

	einfo "Building teTeX"

	econf	--bindir=/usr/bin \
		--datadir=${S} \
		--with-system-wwwlib \
		--with-libwww-include=/usr/include/w3c-libwww \
		--with-system-ncurses \
		--with-system-pnglib \
		--without-texinfo \
		--without-dialog \
		--with-system-zlib \
		--disable-multiplatform \
		--with-epsfwin \
		--with-mftalkwin \
		--with-regiswin \
		--with-tektronixwin \
		--with-unitermwin \
		--with-ps=gs \
		--enable-ipc \
		--with-etex \
		--without-xdvik \
		--without-dvipdfm \
		`use_with X x` || die

	# emake sometimes b0rks on SPARC
	make texmf=/usr/share/texmf || die "make teTeX failed"

	cat <<-EOF>>${S}/texk/web2c/fmtutil.cnf

	# Japanese pLaTeX:
	ptex		ptex	-		ptex.ini
	platex		ptex	language.dat	platex.ini
	platex209	ptex	language.dat	plplain.ini
	EOF

	cd ${S}/texk/web2c/${P}; pwd
	./configure EUC || die "configure pTeX failed"

	make programs || die "make pTeX failed"
}

src_install() {

	dodir /usr/share/

	einfo "Installing texmf..."
	cp -Rv texmf ${D}/usr/share

	# Install teTeX files
	einfo "Installing teTeX..."
	einstall bindir=${D}/usr/bin texmf=${D}/usr/share/texmf || die

	# Install pTeX files
	cd ${S}/texk/web2c/${P}
	einfo "Installing pTeX..."
	einstall bindir=${D}/usr/bin texmf=${D}/usr/share/texmf || die

	insinto /usr/share/texmf/dvips/config
	newins ${FILESDIR}/psfonts-novflib-ja.map psfonts-ja.map
	cat >>${D}/usr/share/texmf/web2c/updmap.cfg<<-EOF

	# Japanese fonts
	MixedMap psfonts-ja.map
	EOF

	cd ${S}

	dodoc PROBLEMS README
	docinto texk
	dodoc texk/ChangeLog texk/README
	docinto kpathesa
	cd ${S}/texk/kpathsea
	dodoc README* NEWS PROJECTS HIER
	docinto dviljk
	cd ${S}/texk/dviljk
	dodoc AUTHORS README NEWS
	docinto dvipsk
	cd ${S}/texk/dvipsk
	dodoc AUTHORS INSTALLATION ChangeLog README \
		../ChangeLog.jpatch ../README.jpatch
	docinto makeindexk
	cd ${S}/texk/makeindexk
	dodoc CONTRIB COPYING NEWS NOTES PORTING README
	docinto ps2pkm
	cd ${S}/texk/ps2pkm
	dodoc ChangeLog CHANGES.type1 INSTALLATION README*
	docinto web2c
	cd ${S}/texk/web2c
	dodoc AUTHORS ChangeLog NEWS PROJECTS README

	#fix for conflicting readlink binary:
	rm -f ${D}/bin/readlink
	rm -f ${D}/usr/bin/readlink
	#add /var/cache/fonts directory
	dodir /var/cache/fonts

	#fix for lousy upstream permisssions on /usr/share/texmf files
	#NOTE: do not use fowners, as its not recursive ...
	einfo "Fixing permissions..."
	chown -R root:root ${D}/usr/share/texmf
	dodir /etc/env.d/
	echo 'CONFIG_PROTECT="/usr/share/texmf/tex/generic/config/ /usr/share/texmf/tex/platex/config/ /usr/share/texmf/dvips/config/ /usr/share/texmf/dvipdfm/config/ /usr/share/texmf/xdvi/"' > ${D}/etc/env.d/98tetex
}

pkg_preinst() {

	# Let's take care of config protecting.
	einfo "Here I am!"
}

pkg_postinst() {

	if [ $ROOT = "/" ]
	then
		einfo "Configuring teTeX..."
		mktexlsr &>/dev/null
		texlinks &>/dev/null
		texconfig init &>/dev/null
		texconfig confall &>/dev/null
		texconfig font rw &>/dev/null
		texconfig font vardir /var/cache/fonts &>/dev/null
		texconfig font options varfonts &>/dev/null
		updmap &>/dev/null
		einfo "Generating format files..."
		#fmtutil --missing &>/dev/null # This should generate all missing fmt files.
		einfo ""
		einfo "Use 'texconfig font ro' to disable font generation for users"
		einfo ""
	fi
}
