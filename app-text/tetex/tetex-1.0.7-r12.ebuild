# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-1.0.7-r12.ebuild,v 1.10 2003/04/12 23:48:02 method Exp $

inherit flag-o-matic
filter-flags "-fstack-protector"

TEXMFSRC="teTeX-texmf-gg-1.0.3.tar.bz2"
S=${WORKDIR}/teTeX-1.0

DESCRIPTION="a complete TeX distribution"
SRC_URI="ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-src-${PV}.tar.gz
	 ftp://ftp.dante.de/pub/tex/systems/unix/teTeX/1.0/contrib/ghibo/${TEXMFSRC}
	 mirror://gentoo/ec-ready-mf-tfm.tar.gz
	 mirror://teTeX-french.tar.gz"
HOMEPAGE="http://tug.org/teTeX/"

KEYWORDS="x86 ppc sparc alpha hppa"
SLOT="0"
LICENSE="GPL-2"
IUSE="ncurses X libwww png zlib"

DEPEND="sys-apps/ed
	X? ( virtual/x11 )
	png? ( >=media-libs/libpng-1.2.1 )
	ncurses? ( sys-libs/ncurses )
	libwww? ( >=net-libs/libwww-5.3.2-r1 )
	zlib? ( sys-libs/zlib )"
RDEPEND=">=dev-lang/perl-5.2
	dev-util/dialog"

src_unpack() {
	unpack teTeX-src-${PV}.tar.gz

	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
	
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
	patch -p0 < ${FILESDIR}/teTeX-1.0-gentoo.diff || die
	cd ${S}
	patch -p0 < ${FILESDIR}/teTeX-1.0.dif || die

	# Do not run config stuff
	patch -p1 < ${FILESDIR}/${P}-dont-run-config.diff || die

	# Fix for dvips to print directly.
	patch -p1 < ${FILESDIR}/teTeX-1.0-dvips.diff || die

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

	local myconf=""
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"

	use libwww \
		&& myconf="${myconf} --with-system-wwwlib
		           --with-libwww-include=/usr/include/w3c-libwww"

	use png \
		&& myconf="${myconf} --with-system-pnglib"

	use ncurses \
		&& myconf="${myconf} --with-system-ncurses"

	use zlib \
		&& myconf="${myconf} --with-system-zlib"

	econf \
		--without-texinfo \
		--without-dialog \
		--disable-multiplatform \
		--with-epsfwin \
		--with-mftalkwin \
		--with-regiswin \
		--with-tektronixwin \
		--with-unitermwin \
		--with-ps=gs \
		--enable-ipc \
		--with-etex \
		${myconf} || die "econf failed"

	# emake seems to not work (18 Jan 2003 agriffis)
	make
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
	chown -R root.root ${D}/usr/share/texmf
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

