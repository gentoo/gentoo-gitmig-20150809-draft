# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.0.2-r1.ebuild,v 1.10 2003/12/31 04:15:20 obz Exp $

inherit eutils flag-o-matic
filter-flags "-fstack-protector"

IUSE="X"

S=${WORKDIR}/tetex-src-${PV}
TETEXSRC="tetex-src-${PV}.tar.gz"
TEXMFSRC="tetex-texmfsrc-${PV}.tar.gz"
TEXMF="tetex-texmf-${PV}.tar.gz"

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"
SRC_URI="ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/2.0/distrib/${TETEXSRC}
	ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/2.0/distrib/${TEXMFSRC}
	ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/2.0/distrib/${TEXMF}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~hppa amd64 ia64"

DEPEND="!app-text/ptex
	!app-text/cstetex
	sys-apps/ed
	sys-libs/zlib
	>=media-libs/libpng-1.2.1
	sys-libs/ncurses
	>=net-libs/libwww-5.3.2-r1
	X? ( virtual/x11 )"

RDEPEND="${DEPEND}
	>=dev-lang/perl-5.2
	dev-util/dialog"

PROVIDE="virtual/tetex"

src_unpack() {
	unpack ${TETEXSRC}

	cd ${WORKDIR}
	mkdir ${S}/texmf
	cd ${S}/texmf
	umask 022
	pwd
	ebegin "Unpacking ${TEXMFSRC}"
	tar --no-same-owner -xzf ${DISTDIR}/${TEXMFSRC}
	eend $?

	ebegin "Unpacking ${TEXMF}"
	tar --no-same-owner -xzf ${DISTDIR}/${TEXMF}
	eend $?

	# Do not run config.  Also fix local texmf tree.
	cd ${WORKDIR}
	cd ${S}
	epatch ${FILESDIR}/${P}-dont-run-config.diff
	epatch ${FILESDIR}/${P}.diff

	# fix up misplaced listings.sty in the 2.0.2 archive. 
	# this should be fixed in the next release <obz@gentoo.org>
	mv texmf/source/latex/listings/listings.sty texmf/tex/latex/listings/

	epatch ${FILESDIR}/${PN}-no-readlink-manpage.diff
}

src_compile() {

	econf \
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
		`use_with X x` \
		${myconf} || die

	make texmf=/usr/share/texmf || die
}

src_install() {

	dodir /usr/share/
	# Install texmf files
	einfo "Installing texmf..."
	cp -Rv texmf ${D}/usr/share

	make prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		texmf=${D}/usr/share/texmf \
		install || die

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
	dodoc AUTHORS ChangeLog INSTALLATION README
	docinto makeindexk
	cd ${S}/texk/makeindexk
	dodoc CONTRIB COPYING NEWS NOTES PORTING README
	docinto ps2pkm
	cd ${S}/texk/ps2pkm
	dodoc ChangeLog CHANGES.type1 INSTALLATION README*
	docinto web2c
	cd ${S}/texk/web2c
	dodoc AUTHORS ChangeLog NEWS PROJECTS README
	docinto xdvik
	cd ${S}/texk/xdvik
	dodoc BUGS FAQ README*

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
	echo 'CONFIG_PROTECT="/usr/share/texmf/tex/generic/config/ /usr/share/texmf/tex/platex/config/"' > ${D}/etc/env.d/98tetex
}

pkg_preinst() {
	if [ -d "/usr/share/texmf/dvipdfm/config" ]
	then
		ewarn "Removing /usr/share/texmf/dvipdfm/config/"
		rm -rf /usr/share/texmf/dvipdfm/config
	fi

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
		einfo "Generating format files..."
		fmtutil --missing &>/dev/null # This should generate all missing fmt files.
		echo
		einfo "Use 'texconfig font ro' to disable font generation for users"
		echo
	fi
}

