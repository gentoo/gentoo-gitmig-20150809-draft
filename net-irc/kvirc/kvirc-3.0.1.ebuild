# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-3.0.1.ebuild,v 1.3 2004/07/15 00:44:42 agriffis Exp $

inherit eutils kde

DESCRIPTION="An advanced IRC Client"
HOMEPAGE="http://www.kvirc.net/"
SRC_URI="ftp://ftp.kvirc.net/pub/kvirc/${PV}/source/${P}.tar.bz2 \
	ftp://ftp.kvirc.de/pub/kvirc/${PV}/source/${P}.tar.bz2 \
	ftp://kvirc.firenze.linux.it/pub/kvirc/${PV}/source/${P}.tar.bz2"

LICENSE="kvirc"
SLOT="3"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="debug esd ipv6 kde oss ssl"

RDEPEND="esd? ( media-sound/esound )
	ssl? ( dev-libs/openssl )
	oss? ( media-libs/audiofile )
	>=x11-libs/qt-3
	kde? ( >=kde-base/kdelibs-3 )
	sys-devel/gettext"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep
	sys-devel/libtool
	sys-apps/sed"

use debug && RESTRICT="nostrip"

src_compile() {

	# use aa even when kde support is disabled; remove the splash screen
	# to speed up the startup.
	local myconf="--with-aa-fonts --without-splash-screen
		--with-big-channels --with-pizza"

	# For myconf, we can't do it the easy way (use_with) because the configure
	# script will assume we're telling it not to include support.
	myconf="${myconf}
		`use_with debug debug-symbols`"
	use kde || myconf="${myconf} --without-kde-support --without-arts-support"
	use ipv6 || myconf="${myconf} --without-ipv6-support"
	use esd || myconf="${myconf} --without-esd-support"
	use ssl || myconf="${myconf} --without-ssl-support"

	[ "$ARCH" == "x86" ] && myconf="$myconf --with-ix86-asm"

	need-autoconf 2.5
	need-automake 1.5

	econf ${myconf} || die "failed to configure"
	emake || die "failed to make"
}

src_install() {
	emake install DESTDIR=${D} || die
	emake docs DESTDIR=${D} || die
	dodoc ChangeLog INSTALL README TODO
}
