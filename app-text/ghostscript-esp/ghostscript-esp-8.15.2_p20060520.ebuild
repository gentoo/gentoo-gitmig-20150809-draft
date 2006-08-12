# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-esp/ghostscript-esp-8.15.2_p20060520.ebuild,v 1.3 2006/08/12 22:04:33 genstef Exp $

inherit eutils autotools versionator

DESCRIPTION="ESP Ghostscript -- an enhanced version of GPL Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/espgs"
ESVN_REPO_URI="http://svn.easysw.com/public/espgs/trunk"

MY_P=espgs-${PV}
PVM=$(get_version_component_range 1-2)
SRC_URI="cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200406.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz )
	http://dev.gentoo.org/~genstef/files/dist/${MY_P}-source.tar.bz2
	http://dev.gentoo.org/~genstef/files/dist/ghostscript-esp-8.15.1-ubuntu4.patch.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X cups cjk emacs gtk threads xml"

DEP="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( || ( x11-libs/libXt virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( >=net-print/cups-1.1.20 )
	xml? ( >=dev-libs/libxml2-2.6.8 )
	media-libs/fontconfig
	!app-text/ghostscript-gnu
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
	fi
	cd ${S}

	# http://cups.org/espgs/str.php?L1627
	epatch ${FILESDIR}/ghostscript-esp-8.15.1-fPIC.patch
	# http://cups.org/espgs/str.php?L1628
	epatch ${FILESDIR}/ghostscript-esp-8.15.1-bsd.patch
	# http://cups.org/espgs/str.php?L1629
	epatch ${FILESDIR}/ghostscript-esp-8.15.2-destdir.diff
	# http://cups.org/espgs/str.php?L1633
	epatch ${FILESDIR}/ghostscript-esp-8.15.2-gtk-configure.patch
	# http://cups.org/espgs/str.php?L1635
	epatch ${WORKDIR}/ghostscript-esp-8.15.1-ubuntu4.patch
	# http://cups.org/espgs/str.php?L1639
	epatch ${FILESDIR}/ghostscript-split-font-configuration.patch
	# http://cups.org/espgs/str.php?L1640
	epatch ${FILESDIR}/ghostscript-esp-8.15.2-noopt.patch
	# http://cups.org/espgs/str.php?L1641
	epatch ${FILESDIR}/ghostscript-pagesize.patch
	# http://cups.org/espgs/str.php?L1644
	epatch ${FILESDIR}/ghostscript-esp-8.15.2-big-cmap-post.patch
	# http://cups.org/espgs/str.php?L1712
	epatch ${FILESDIR}/ghostscript-esp-8.15.2-cups-1.1.patch

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		src/Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		src/Makefile.in || die "sed failed"
	sed -i -e "s:exdir=[^ ]*:exdir=/usr/share/doc/${PF}/examples:" \
		src/Makefile.in || die "sed failed"

	ln -s src/configure.ac .
	ln -s src/Makefile.in .
	cp /usr/share/automake-1.9/install-sh "${S}"
	AT_NOELIBTOOLIZE="yes" eautoreconf
	cd ijs
	AT_NOELIBTOOLIZE="yes" eautoreconf
	elibtoolize
}

src_compile() {
	local myconf
	myconf="--with-ijs --with-jbig2dec"

	# gs -DPARANOIDSAFER out.ps
	myconf="${myconf} --with-fontconfig --with-fontpath=/usr/share/fonts:/usr/share/fonts/ttf/zh_TW:/usr/share/fonts/ttf/zh_CN:/usr/share/fonts/arphicfonts:/usr/share/fonts/ttf/korean/baekmuk:/usr/share/fonts/baekmuk-fonts:/usr/X11R6/lib/X11/fonts/truetype:/usr/share/fonts/kochi-substitute"

	# *-dynmic breaks compiling without X, see bug 121749
	use X && myconf="${myconf} --enable-dynamic"

	econf $(use_with X x) \
		$(use_enable gtk) \
		$(use_enable cups) \
		$(use_enable threads) \
		$(use_with xml omni) \
		${myconf} || die "econf failed"
	emake -j1 so all || die "emake failed"

	cd ijs
	econf || die "ijs econf failed"
	emake || die "ijs emake failed"
}

src_install() {
	make DESTDIR="${D}" install soinstall || die "make install failed"

	rm -fr ${D}/usr/share/ghostscript/${PVM}/doc
	dodoc doc/README
	dohtml doc/*.html doc/*.htm
	ln -s /usr/share/doc/${PF}/html ${D}/usr/share/ghostscript/${PVM}/doc

	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins doc/gsdoc.el
	fi

	cd ${S}/ijs
	make DESTDIR="${D}" install || die "ijs install failed"
}

pkg_postinst() {
	ewarn "If you are upgrading from ghostscript-7 you need to rebuild"
	ewarn "gimp-print. Please run 'revdep-rebuild' to do this."
}
