# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.74-r2.ebuild,v 1.1 2004/01/02 20:06:30 rizzo Exp $

IUSE="nls perl spell nas ssl mozilla cjk debug"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
EV=2.18
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2
	ssl? ( mirror://sourceforge/gaim-encryption/gaim-encryption-${EV}.tar.gz )"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

DEPEND="=sys-libs/db-1*
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	sys-devel/gettext
	media-libs/libao
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.6.1
		>=sys-apps/sed-4.0.0 )
	mozilla? ( net-www/mozilla )
	!mozilla? ( dev-libs/nss )
	spell? ( >=app-text/gtkspell-2.0.2 )"

src_unpack() {
	unpack ${P}.tar.bz2 || die
	cd ${S}
	epatch ${FILESDIR}/gaim-0.74-log_free.patch
	epatch ${FILESDIR}/gaim-0.74-scs-msg-yahoo.patch
	use cjk && epatch ${FILESDIR}/gaim-0.74_cjk_gtkconv.patch

	use ssl && {
		cd ${S}/plugins
		unpack gaim-encryption-${EV}.tar.gz
		cd ${S}/plugins/gaim-encryption-${EV}
		epatch ${FILESDIR}/gaim-encryption-2.18-moz1.6.patch
	}
}

src_compile() {

	local myconf
	use perl || myconf="${myconf} --disable-perl"
	use spell || myconf="${myconf} --disable-gtkspell"
	use nls  || myconf="${myconf} --disable-nls"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"
	use debug  && myconf="${myconf} --enable-debug"

	NSS_LIB=/usr/lib
	NSS_INC=/usr/include
	use mozilla || {
		# Only need to specify this if no pkgconfig from mozilla
		myconf="${myconf} --with-nspr-includes=${NSS_INC}/nspr"
		myconf="${myconf} --with-nss-includes=${NSS_INC}/nss"
		myconf="${myconf} --with-nspr-libs=${NSS_LIB}"
		myconf="${myconf} --with-nss-libs=${NSS_LIB}"
	}

	econf ${myconf} || die "Configuration failed"
	use perl && sed -i -e 's:^\(PERL_MM_PARAMS =.*PREFIX=\)\(.*\):\1'${D}'\2:' plugins/perl/Makefile

	einfo "Replacing -Os CFLAG with -O2"
	replace-flags -Os -O2

	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "Make failed"

	use ssl && {
		local myencconf
		cd ${S}/plugins/gaim-encryption-${EV}

		use mozilla || {
			# Only need to specify this if no pkgconfig from mozilla
			myencconf="${myencconf} --with-nspr-includes=${NSS_INC}/nspr"
			myencconf="${myencconf} --with-nss-includes=${NSS_INC}/nss"
			myencconf="${myencconf} --with-nspr-libs=${NSS_LIB}"
			myencconf="${myencconf} --with-nss-libs=${NSS_LIB}"
		}
		econf ${myencconf} || die "Configuration failed for encryption"
		emake || die "Make failed for encryption"
	}
}

src_install() {
	einstall || die "Install failed"
	use ssl && {
		cd ${S}/plugins/gaim-encryption-${EV}
		einstall || die "Install failed for encryption"
		cd ${S}
	}
	dodoc ABOUT-NLS AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog VERSION
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

	if [ `use ssl` ]; then
		ewarn
		ewarn "You have chosen (by selecting 'USE=ssl') to install"
		ewarn "the gaim-encryption plugin ( http://gaim-encryption.sf.net/ )"
		ewarn "this plugin is NOT supported by the Gaim project, and if you"
		ewarn "expierence problems related to it, contact the Gentoo project"
		ewarn "via http://bugs.gentoo.org/ or the gaim-encryption project."
		ewarn
	fi

	einfo
	einfo "Yahoo! has changed their IM server.  Existing profiles should"
	einfo "change the server for their Yahoo! IM accounts to scs.msg.yahoo.com"
	einfo
}
