# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-9999.ebuild,v 1.3 2006/06/07 07:58:34 jokey Exp $

inherit eutils kde-functions cvs autotools

DESCRIPTION="An advanced IRC Client"
HOMEPAGE="http://www.kvirc.net/"

LICENSE="kvirc"
SLOT="3"
KEYWORDS="-*"
IUSE="debug esd ipv6 kde oss ssl"

RDEPEND="esd? ( media-sound/esound )
	ssl? ( dev-libs/openssl )
	oss? ( media-libs/audiofile )
	kde? ( >=kde-base/kdelibs-3 )
	=x11-libs/qt-3*"

DEPEND="${RDEPEND}
	sys-devel/gettext"

ECVS_SERVER="cvs.kvirc.net:/cvs"
ECVS_MODULE="kvirccvs/kvirc"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${P}"

S="${WORKDIR}/${ECVS_MODULE}"

src_unpack() {
	cvs_src_unpack
	cd ${S}
	einfo "Generating configure script, this takes a moment"
	./autogen.sh
	epatch ${FILESDIR}/${PN}-3.2.3-kdedir-fix.patch
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

	need-autoconf 2.5
	need-automake 1.5

	econf ${myconf} || die "failed to configure"
	emake -j1 || die "failed to make"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	make docs DESTDIR="${D}" || die "make docs failed"
	dodoc ChangeLog README TODO
}
