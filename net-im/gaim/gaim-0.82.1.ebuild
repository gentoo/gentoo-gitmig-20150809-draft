# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.82.1.ebuild,v 1.7 2004/09/06 00:17:59 ciaranm Exp $

inherit flag-o-matic eutils gcc debug

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips ~alpha hppa ~amd64 ~ia64"
IUSE="nls perl spell nas crypt cjk gnutls silc evo"

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	sys-devel/gettext
	media-libs/libao
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.8.2-r1
			!<dev-perl/ExtUtils-MakeMaker-6.17 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	dev-libs/nss
	gnutls? ( net-libs/gnutls )
	silc? ( >=net-im/silc-toolkit-0.9.12-r2 )
	evo? ( mail-client/evolution )"

PDEPEND="crypt? ( >=x11-plugins/gaim-encryption-2.30 )"

print_gaim_warning() {
	ewarn
	ewarn "If you are merging ${P} from an earlier version, you will need"
	ewarn "to re-merge any plugins like gaim-encryption or gaim-snpp."
	ewarn
	ewarn "If you experience problems with gaim, file them as bugs with"
	ewarn "Gentoo's bugzilla, http://bugs.gentoo.org.  DO NOT report them"
	ewarn "as bugs with gaim's sourceforge tracker, and by all means DO NOT"
	ewarn "seek help in #gaim."
	ewarn
	ewarn "Be sure to USE=\"debug\" and include a backtrace for any seg"
	ewarn "faults, see http://gaim.sourceforge.net/gdb.php for details on"
	ewarn "backtraces."
	ewarn
	ewarn "Please read the gaim FAQ at http://gaim.sourceforge.net/faq.php"
	ewarn
	einfo
	einfo "Note that we are now filtering all unstable flags in C[XX]FLAGS."
	einfo
	ebeep 5
	epause 3
}

pkg_setup() {
	print_gaim_warning
}

src_unpack() {
	unpack ${A}
	cd ${S}
	use cjk && epatch ${FILESDIR}/gaim-0.76-xinput.patch
	cd ${S}/src
	epatch ${FILESDIR}/gaim-0.83cvs-gtkcellrendererprogress.diff
}

src_compile() {
	# Stabilize things, for your own good
	strip-flags
	replace-flags -O? -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf
	use perl || myconf="${myconf} --disable-perl"
	use spell || myconf="${myconf} --disable-gtkspell"
	use nls  || myconf="${myconf} --disable-nls"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"
	use evo || myconf="${myconf} --disable-gevolution"

	if use gnutls ; then
		myconf="${myconf} --with-gnutls-includes=/usr/include/gnutls"
		myconf="${myconf} --with-gnutls-libs=/usr/lib"
	else
		myconf="${myconf} --enable-gnutls=no"
	fi

	if use silc ; then
		myconf="${myconf} --with-silc-includes=/usr/include/silc-toolkit"
		myconf="${myconf} --with-silc-libs=/usr/lib"
	fi

	myconf="${myconf} --with-nspr-includes=/usr/include/nspr"
	myconf="${myconf} --with-nss-includes=/usr/include/nss"
	myconf="${myconf} --with-nspr-libs=/usr/lib"
	myconf="${myconf} --with-nss-libs=/usr/lib"

	econf ${myconf} || die "Configuration failed"

	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "Make failed"
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc ABOUT-NLS AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog VERSION
}

pkg_postinst() {
	print_gaim_warning
}
