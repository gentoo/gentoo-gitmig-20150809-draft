# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-3.2.6_pre20070714.ebuild,v 1.6 2007/09/06 12:13:35 jokey Exp $

inherit autotools eutils kde-functions

DESCRIPTION="An advanced IRC Client"
HOMEPAGE="http://www.kvirc.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="kvirc"
SLOT="3"
KEYWORDS="amd64 ~mips ppc sparc x86"
IUSE="debug esd ipv6 kde oss ssl"

RDEPEND="esd? ( media-sound/esound )
	ssl? ( dev-libs/openssl )
	oss? ( media-libs/audiofile )
	kde? ( >=kde-base/kdelibs-3 )
	=x11-libs/qt-3*"

DEPEND="${RDEPEND}
	sys-devel/gettext"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	./autogen.sh
	epatch "${FILESDIR}"/${PN}-svn-kdedir-fix.patch
	epatch "${FILESDIR}"/${PN}-noipv6.patch
	epatch "${FILESDIR}"/${PN}-gendoc.patch
}

src_compile() {
	set-qtdir 3
	set-kdedir 3

	# use aa even when kde support is disabled; remove the splash screen
	# to speed up the startup.
	local myconf="--with-aa-fonts --without-splash-screen
		--with-big-channels --with-pizza"

	# For myconf, we can't do it the easy way (use_with) because the configure
	# script will assume we're telling it not to include support.
	myconf="${myconf} `use_with debug debug-symbols`"
	use kde || myconf="${myconf} --without-kde-support --without-arts-support"
	use ipv6 || myconf="${myconf} --without-ipv6-support"
	use esd || myconf="${myconf} --without-esd-support"
	use ssl || myconf="${myconf} --without-ssl-support"

	[ "${ARCH}" == "x86" ] && myconf="${myconf} --with-ix86-asm"

	econf ${myconf} || die "econf failed"
	emake -j1 || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" docs || die "emake docs failed"
	dodoc ChangeLog INSTALL README TODO
}
