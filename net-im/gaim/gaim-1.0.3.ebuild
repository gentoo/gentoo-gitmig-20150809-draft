# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-1.0.3.ebuild,v 1.3 2004/11/15 20:01:14 corsair Exp $

inherit flag-o-matic eutils gcc debug

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~ppc64"
#IUSE="nls perl spell nas crypt cjk gnutls silc eds debug"
IUSE="nls perl spell nas crypt cjk gnutls silc debug"

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	dev-util/pkgconfig
	sys-devel/gettext
	media-libs/libao
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.8.2-r1
			!<dev-perl/ExtUtils-MakeMaker-6.17 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	dev-libs/nss
	gnutls? ( net-libs/gnutls )
	silc? ( >=net-im/silc-toolkit-0.9.12-r3 )"
	#eds? ( gnome-extra/evolution-data-server )"

PDEPEND="crypt? ( >=x11-plugins/gaim-encryption-2.32 )"

# List of plugins
#	net-im/gaim-blogger
#	net-im/gaim-meanwhile
#	net-im/gaim-snpp
#	x11-plugins/autoprofile
#	x11-plugins/gaim-encryption
#	x11-plugins/gaim-extprefs
#	x11-plugins/gaim-rhythmbox
#	x11-plugins/gaim-xmms-remote
#	x11-plugins/gaimosd
#	x11-plugins/guifications


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
	ewarn
	ewarn "If you receive errors due to NSS, please re-emerge"
	ewarn "dev-libs/nss and then emerge gaim again."
	ewarn
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
}

src_compile() {
	# Stabilize things, for your own good
	strip-flags
	replace-flags -O? -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf
	use debug && myconf="${myconf} --enable-debug"
	use perl || myconf="${myconf} --disable-perl"
	use spell || myconf="${myconf} --disable-gtkspell"
	use nls  || myconf="${myconf} --disable-nls"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"
	myconf="${myconf} --disable-gevolution"
	#use eds || myconf="${myconf} --disable-gevolution"

	if use gnutls ; then
		myconf="${myconf} --with-gnutls-includes=/usr/include/gnutls"
		myconf="${myconf} --with-gnutls-libs=/usr/lib"
	else
		myconf="${myconf} --enable-gnutls=no"
	fi

	myconf="${myconf} --with-nspr-includes=/usr/include/nspr"
	myconf="${myconf} --with-nss-includes=/usr/include/nss"
	myconf="${myconf} --with-nspr-libs=/usr/lib"
	myconf="${myconf} --with-nss-libs=/usr/lib/nss"

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
