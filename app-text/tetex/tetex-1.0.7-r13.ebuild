# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-1.0.7-r13.ebuild,v 1.9 2004/04/08 22:58:31 vapier Exp $

inherit eutils flag-o-matic

TEXMFSRC="teTeX-texmf-gg-1.0.3.tar.bz2"
S=${WORKDIR}/teTeX-1.0

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"
SRC_URI="ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-src-${PV}.tar.gz
	 ftp://ftp.dante.de/pub/tex/systems/unix/teTeX/1.0/contrib/ghibo/${TEXMFSRC}
	 mirror://gentoo/ec-ready-mf-tfm.tar.gz
	 mirror://teTeX-french.tar.gz"

KEYWORDS="x86 ppc sparc alpha hppa"
SLOT="0"
LICENSE="GPL-2"
IUSE="X"

DEPEND="!app-text/ptex
	!app-text/cstetex
	sys-apps/ed
	X? ( virtual/x11 )
	>=media-libs/libpng-1.2.1
	sys-libs/ncurses
	>=net-libs/libwww-5.3.2-r1
	sys-libs/zlib"
RDEPEND="${DEPEND}
	>=dev-lang/perl-5.2
	dev-util/dialog"
PROVIDE="virtual/tetex"

src_unpack() {
	unpack teTeX-src-${PV}.tar.gz

	cd ${S}
	epatch ${FILESDIR}/${P}-dvips-secure.diff

	mkdir ${S}/texmf
	cd ${S}/texmf
	umask 022
	echo ">>> Unpacking ${TEXMFSRC}"
	tar --no-same-owner -xjf ${DISTDIR}/${TEXMFSRC} || die
	echo ">>> Unpacking ec-ready-mf-tfm.tar.gz"
	tar --no-same-owner -xzf ${DISTDIR}/ec-ready-mf-tfm.tar.gz -C .. || die
	echo ">>> Unpacking teTeX-french.tar.gz"
	tar --no-same-owner -xzf ${DISTDIR}/teTeX-french.tar.gz || die

	# Fixes from way back ... not sure even Achim will
	# still know why :/
	cd ${WORKDIR}
	epatch ${FILESDIR}/teTeX-1.0-gentoo.diff
	cd ${S}
	epatch ${FILESDIR}/teTeX-1.0.dif

	# Do not run config stuff
	epatch ${FILESDIR}/${P}-dont-run-config.diff

	# Fix for dvips to print directly.
	epatch ${FILESDIR}/teTeX-1.0-dvips.diff

	# Fix picins.sty 
	epatch ${FILESDIR}/${P}-picins.diff

	# Prevent the silly readlink manpage from installing
	epatch ${FILESDIR}/${PN}-no-readlink-manpage.diff

	# Fix problem where the *.fmt files are not generated due to the LaTeX
	# source being older than a year.
	local x
	for x in `find ${S}/texmf/ -type f -name '*.ini'`
	do
		cp ${x} ${x}.orig
		sed -e '1i \\scrollmode' ${x}.orig > ${x}
		rm -f ${x}.orig
	done

	# IMPORTANT!  If you're having *.fmt problems, do this:
	# fmtutil --all
	# after the merge.
}

src_compile() {
	filter-flags -fstack-protector

	local myconf=""
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"

	econf \
		--without-texinfo \
		--without-dialog \
		--disable-multiplatform \
		--with-epsfwin \
		--with-mftalkwin \
		--with-regiswin \
		--with-system-wwwlib \
		--with-libwww-include=/usr/include/w3c-libwww \
		--with-system-pnglib \
		--with-system-ncurses \
		--with-system-zlib \
		--with-tektronixwin \
		--with-unitermwin \
		--with-ps=gs \
		--enable-ipc \
		--with-etex \
		${myconf} || die "econf failed"

	# emake seems to not work (18 Jan 2003 agriffis)
	make || die
}

src_install() {
	dodir /usr/share/
	# Install texmf files
	einfo "Installing texmf..."
	cp -Rv texmf ${D}/usr/share || die "cp -Rv texmf failed"

	einstall \
		texmf=${D}/usr/share/texmf \
		texmfmain=${D}/usr/share/texmf \
		mandir=${D}/usr/share/man/man1 \
		|| die "einstall failed"

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
}

pkg_postinst() {
	if [ $ROOT = "/" ]
	then
		einfo "Configuring teTeX..."
		mktexlsr &>/dev/null
		texlinks &>/dev/null
		texconfig init &>/dev/null
		texconfig confall &>/dev/null
		texconfig font vardir /var/cache/fonts &>/dev/null

		# Fix bug 13789; this should really be done by texconfig init
		# but oh well, it will probably be fixed by 2.0, right? ;-)
		# (18 Jan 2003 agriffis)
		( cd /var/lib/texmf/web2c; inimf mf; ) &>/dev/null

		einfo "Generating format files..."
		fmtutil --missing &>/dev/null # This should generate all missing fmt files.

		echo
		einfo "Use 'texconfig font rw' to allow all users to generate fonts."
		echo
	fi
}
