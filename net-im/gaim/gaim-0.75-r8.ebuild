# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.75-r8.ebuild,v 1.12 2004/03/19 17:31:58 rizzo Exp $

inherit flag-o-matic eutils gcc

IUSE="nls perl spell nas cjk debug crypt"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc alpha ia64 hppa"

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	sys-devel/gettext
	media-libs/libao
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.6.1
		>=sys-apps/sed-4.0.0 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	|| ( dev-libs/nss net-www/mozilla )"
PDEPEND="crypt? ( net-im/gaim-encryption )"

pkg_setup() {
	ewarn
	ewarn "If you experience problems with gaim, file them as bugs with"
	ewarn "Gentoo's bugzilla, http://bugs.gentoo.org.  DO NOT report them"
	ewarn "as bugs with gaim's sourceforge tracker, and by all means DO NOT"
	ewarn "seek help in #gaim."
	ewarn
}

src_unpack() {
	unpack ${P}.tar.bz2 || die
	cd ${S}
	epatch ${FILESDIR}/gaim-0.75-static-prpls.patch
	epatch ${FILESDIR}/gaim-0.76cvs-signals-varargs.diff
	epatch ${FILESDIR}/gaim-0.76cvs-yahoo-login-fix.diff
	epatch ${FILESDIR}/gaim-0.75-yahoo-security.diff
	use cjk && epatch ${FILESDIR}/gaim-0.74_cjk_gtkconv.patch
}

src_compile() {
	einfo "Replacing -Os CFLAG with -O2"
	replace-flags -Os -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf
	use perl || myconf="${myconf} --disable-perl"
	use spell || myconf="${myconf} --disable-gtkspell"
	use nls  || myconf="${myconf} --disable-nls"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"
	use debug  && myconf="${myconf} --enable-debug"

	NSS_LIB=/usr/lib
	NSS_INC=/usr/include
	has_version dev-libs/nss && {
		# Only need to specify this if no pkgconfig from mozilla
		myconf="${myconf} --with-nspr-includes=${NSS_INC}/nspr"
		myconf="${myconf} --with-nss-includes=${NSS_INC}/nss"
		myconf="${myconf} --with-nspr-libs=${NSS_LIB}"
		myconf="${myconf} --with-nss-libs=${NSS_LIB}"
	}

	econf ${myconf} || die "Configuration failed"
	use perl && sed -i -e 's:^\(PERL_MM_PARAMS =.*PREFIX=\)\(.*\):\1'${D}'\2:' plugins/perl/Makefile

	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ABOUT-NLS AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog VERSION

	# Copy header files for gaim plugin use
	dodir /usr/include/gaim/src
	cp config.h ${D}/usr/include/gaim/
	cd ${S}/src
	#tar cf - `find . -name \*.h` | (cd ${D}/usr/include/gaim/src ; tar xvf -)
	tar cf - *.h | (cd ${D}/usr/include/gaim/src ; tar xvf -)
	assert "Failed to install header files to /usr/include/gaim"
}

pkg_postinst() {
	if [ `use cjk` ]; then
		ewarn
		ewarn "You have chosen (by selecting 'USE=cjk') to compile with"
		ewarn "a patch for CJK support.  Please be aware that this patch"
		ewarn "causes problems with skkinput.  kinput2 works fine.  Details"
		ewarn "can be found at http://bugs.gentoo.org/show_bug.cgi?id=24657#c23"
		ewarn
	fi

	ewarn
	ewarn "If you experience problems with gaim, file them as bugs with"
	ewarn "Gentoo's bugzilla, http://bugs.gentoo.org.  DO NOT report them"
	ewarn "as bugs with gaim's sourceforge tracker, and by all means DO NOT"
	ewarn "seek help in #gaim."
	ewarn
}
