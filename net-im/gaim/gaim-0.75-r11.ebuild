# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.75-r11.ebuild,v 1.5 2004/04/01 04:16:24 lv Exp $

inherit flag-o-matic eutils gcc
use debug && inherit debug

IUSE="nls perl spell nas cjk debug crypt gnome"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha ~ia64 ~mips"

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	sys-devel/gettext
	media-libs/libao
	>=sys-apps/sed-4.0.0
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.6.1 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	|| ( dev-libs/nss net-www/mozilla )
	gnome? ( >=gnome-base/libgnome-2.4.0 )"
PDEPEND="crypt? ( net-im/gaim-encryption )"

pkg_setup() {
	ewarn
	ewarn "If you experience problems with gaim, file them as bugs with"
	ewarn "Gentoo's bugzilla, http://bugs.gentoo.org.  DO NOT report them"
	ewarn "as bugs with gaim's sourceforge tracker, and by all means DO NOT"
	ewarn "seek help in #gaim."
	ewarn
	ewarn "Be sure to include a backtrace for any seg faults, see"
	ewarn "http://gaim.sourceforge.net/gdb.php for details on backtraces."
	ewarn
	for TICKER in 1 2 3 4 5; do
		# Double beep here.
		echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
		echo -ne "\a" ; sleep 1
	done
	sleep 8
}

src_unpack() {
	unpack ${P}.tar.bz2 || die
	cd ${S}
	epatch ${FILESDIR}/gaim-0.75-static-prpls.patch
	epatch ${FILESDIR}/gaim-0.76cvs-signals-varargs.diff
	epatch ${FILESDIR}/gaim-0.76cvs-yahoo-login-fix.diff
	epatch ${FILESDIR}/gaim-0.75-yahoo-security.diff
	epatch ${FILESDIR}/gaim-0.76cvs-yahoo-misc-fixes-1.diff

	has_version '>=sys-devel/gettext-0.12.1' && {
		# put in gentoo branding
		sed "s/GAIM_VERSION/${PV}/; s/GENTOO_EBUILD_VERSION/${PV}-gentoo-${PR%r0}/" \
			${FILESDIR}/gaim-gentoo-branding.patch \
			> ${WORKDIR}/gaim-gentoo-branding.patch
		epatch ${WORKDIR}/gaim-gentoo-branding.patch
	}

	use cjk && epatch ${FILESDIR}/gaim-0.74_cjk_gtkconv.patch
	use gnome && epatch ${FILESDIR}/gaim-0.74-gnome-url-handler.patch
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

	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "Make failed"
	has_version '>=sys-devel/gettext-0.12.1' && sed -i -e 's:mkinstalldirs =.*:mkinstalldirs = \$\(MKINSTALLDIRS\):' po/Makefile
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc ABOUT-NLS AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog VERSION

	# Copy header files for gaim plugin use
	dodir /usr/include/gaim/src
	cp config.h ${D}/usr/include/gaim/
	cd ${S}/src
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
	ewarn "Be sure to include a backtrace for any seg faults, see"
	ewarn "http://gaim.sourceforge.net/gdb.php for details on backtraces."
	ewarn
	for TICKER in 1 2 3 4 5; do
		# Double beep here.
		echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
		echo -ne "\a" ; sleep 1
	done
	sleep 8
}
