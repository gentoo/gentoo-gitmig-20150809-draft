# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle/ogle-0.9.2.ebuild,v 1.13 2005/04/01 21:20:19 hansmi Exp $

inherit eutils libtool

DESCRIPTION="Full featured DVD player that supports DVD menus."
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc amd64 alpha ia64 ~sparc"
LICENSE="GPL-2"
IUSE="oss mmx alsa xv"

DEPEND=">=media-libs/libdvdcss-1.2.2
	media-libs/jpeg
	>=media-libs/libdvdread-0.9.4
	media-sound/madplay
	virtual/x11
	>=dev-libs/libxml2-2.4.19
	>=media-libs/a52dec-0.7.3
	alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ogle-configure-alsa-fix.patch || die "applying alsa-fix failed"
	epatch ${FILESDIR}/ogle-gcc34-fix.patch
}

src_compile() {
	# STOP!  If you make any changes, make sure to unmerge all copies
	# of ogle and ogle-gui from your system and merge ogle-gui using your
	# new version of ogle... Changes in this package can break ogle-gui
	# very very easily -- blocke

	local myconf="`use_enable mmx` `use_enable oss` `use_enable alsa`"

	use xv && myconf="${myconf} --enable-xv" || myconf="${myconf} --disable-xv"

	if [ "${ARCH}" = "ppc" ] ; then
		# if this user doesn't want altivec, don't compile it in
		# fixes #14939
		if [ `echo ${CFLAGS} | grep -e "-maltivec" | wc -l` = "0" ]
		then
			einfo "Disabling alitvec support"
			myconf="${myconf} --disable-altivec"
		else
			einfo "Enabling altivec support"
			myconf="${myconf} --enable-altivec"
		fi
	fi

	elibtoolize

	# configure needs access to the updated CFLAGS
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml -I/usr/include/libxml2"

	econf ${myconf} || die "./configure failed"
	emake CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	cd ${D}usr/bin/
	mv ./ifo_dump ./ifo_dump_ogle

	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS README TODO
	dodoc doc/liba52.txt
}
