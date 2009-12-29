# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ushare/ushare-1.1a.ebuild,v 1.2 2009/12/29 05:21:57 darkside Exp $

inherit eutils

DESCRIPTION="uShare is a UPnP (TM) A/V & DLNA Media Server"
HOMEPAGE="http://ushare.geexbox.org/"
SRC_URI="http://ushare.geexbox.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dlna nls"

RDEPEND="net-libs/libupnp
		dlna? ( media-libs/libdlna )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf
	myconf="--prefix=/usr --disable-strip $(use_enable dlna)"
	# nls can only be disabled, on by default.
	use nls || myconf="${myconf} --disable-nls"

	# remove original init.d
	sed -i \
		-e '/(INSTALL) -d $(sysconfdir)\/init\.d/d' \
		-e '/$(INSTALL) -m 755 $(INITD_FILE) $(sysconfdir)\/init.d/d' \
		scripts/Makefile || die

	# note: homegrown configure, careful.
	./configure ${myconf} || die "Configure failed"

	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	doman src/ushare.1 || die
	newconfd "${FILESDIR}"/ushare.conf.d ushare || die
	newinitd "${FILESDIR}"/ushare.init.d ushare || die
	dodoc NEWS README TODO THANKS AUTHORS || die
}

pkg_postinst() {
	enewuser ushare
	elog "Please edit /etc/conf.d/ushare to set the shared directories"
	elog "and other important settings. Check system log if ushare is"
	elog "not booting."
}
