# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-20020901-r1.ebuild,v 1.3 2002/09/16 14:14:58 azarah Exp $

TETEXSRC="teTeX-src-beta-${PV}.tar.gz"
TEXMFSRC="teTeX-texmfsrc-beta-20020829.tar.gz"
TEXMF="teTeX-texmf-beta-${PV}.tar.gz"

S=${WORKDIR}/teTeX-src-beta-${PV}
DESCRIPTION="teTeX is a complete TeX distribution"
SRC_URI=" ftp://ftp.dante.de/tex-archive/systems/unix/teTeX-beta/${TETEXSRC}
	ftp://ftp.dante.de/tex-archive/systems/unix/teTeX-beta/${TEXMFSRC}
	ftp://ftp.dante.de/tex-archive/systems/unix/teTeX-beta/${TEXMF}
	mirror://gentoo/ec-ready-mf-tfm.tar.gz
	mirror://gentoo/teTeX-french.tar.gz"
HOMEPAGE="http://tug.cs.umb.edu/tetex/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="sys-apps/ed
	sys-libs/zlib 
	X? ( virtual/x11 )
	png? ( >=media-libs/libpng-1.2.1 )
	ncurses? ( sys-libs/ncurses )
	libwww? ( >=net-libs/libwww-5.4.0-r1 )"

RDEPEND=">=sys-devel/perl-5.2
	dev-util/dialog"

src_unpack() {

	unpack ${TETEXSRC}
	
	mkdir -p ${S}/texmf
	cd ${S}/texmf
	echo ">>> Unpacking ${TEXMFSRC}"
	tar xzf ${DISTDIR}/${TEXMFSRC} || die "Failed to unpack ${TEXMFSRC}!"
	echo ">>> Unpacking ${TEXMF}"
	tar xzf ${DISTDIR}/${TEXMF} || die "Failed to unpack ${TEXMF}!"
	echo ">>> Unpacking ec-ready-mf-tfm.tar.gz"
	tar xzf ${DISTDIR}/ec-ready-mf-tfm.tar.gz -C .. || \
		die "Failed to unpack ec-ready-mf-tfm.tar.gz!"
	echo ">>> Unpacking teTeX-french.tar.gz"
	tar xzf ${DISTDIR}/teTeX-french.tar.gz || \
		die "Failed to unpack teTeX-french.tar.gz!"

	cd ${S}
	# Fix invalid font mappings.
	patch -p0 < ${FILESDIR}/${P}-fontmap.diff || die
	# Change TEXMFLOCAL to /usr/local/share/texmf by default.
	patch -p1 < ${FILESDIR}/${P}-local.diff || die

	# Do not run config stuff during 'make install'
	# Rather do it here, as we really should not do it during
	# src_install().
	patch -p1 < ${FILESDIR}/${P}-dont-run-config.diff || die
	
	if [ "`use ncurses`" ]
	then
		cd ${S}/texk/tetex
		sed 's/tcdialog/dialog/g' texconfig > tc-gentoo
		mv tc-gentoo texconfig
	fi
}

src_compile() {

	local myconf=""
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"

	use libwww \
		&& myconf="${myconf} --with-system-wwwlib"

	use png \
		&& myconf="${myconf} --with-system-pnglib"
	
	use ncurses \
		&& myconf="${myconf} --with-system-ncurses \
		                     --with-ncurses-libdir=/usr/lib \
		                     --with-ncurses-include=/usr/include"
	
	./configure --host=${CHOST} \
		--prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=${S} \
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
		${myconf} || die

	make texmf=/usr/share/texmf || die
}

src_install() {

	dodir /usr/share/
	einfo "Installing texmf data..."
	cp -af texmf ${D}/usr/share
	
	make prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		texmf=${D}/usr/share/texmf \
		-f Makefile \
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

	# Fix for conflicting readlink binary.
	rm -f ${D}/bin/readlink
	# Add /var/cache/fonts directory.
	dodir /var/cache/fonts

	# Fix for lousy upstream permissions on /usr/share/texmf files
	# NOTE: fowners is not recursive...
	einfo "Fixing permissions and ownership..."
	chown -R root.root ${D}/usr/share/texmf/*
	-find ${D}/usr/share/texmf/ -type d -exec chmod a+rx {} \;
	-find ${D}/usr/share/texmf/ -type f -exec chmod a+r {} \;
}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		einfo "Configuring teTeX..."
		mktexlsr &> /dev/null
        fmtutil --all &> /dev/null
		texlinks &> /dev/null
		texconfig init &> /dev/null
		texconfig confall &> /dev/null
		texconfig font vardir /var/cache/fonts &> /dev/null
		texconfig font rw &> /dev/null
		echo
		
		einfo "****************************************************"
		einfo " To allow only root to generate fonts, use:"
		einfo
		einfo "   # texconfig font ro"
		einfo 
		einfo "****************************************************"
	fi
}

