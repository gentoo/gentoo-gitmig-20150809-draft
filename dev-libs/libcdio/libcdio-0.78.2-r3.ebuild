# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcdio/libcdio-0.78.2-r3.ebuild,v 1.2 2008/01/10 09:00:15 vapier Exp $

inherit eutils libtool multilib

DESCRIPTION="A library to encapsulate CD-ROM reading and control"
HOMEPAGE="http://www.gnu.org/software/libcdio/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="cddb minimal nls nocxx"

RDEPEND="cddb? ( >=media-libs/libcddb-1.0.1 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gcc-4.3-includes.patch"
	epatch "${FILESDIR}/${P}-bug203777.patch"
	elibtoolize
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable cddb) \
		$(use_with !minimal cd-drive) \
		$(use_with !minimal cd-info) \
		$(use_with !minimal cd-paranoia) \
		$(use_with !minimal cdda-player) \
		$(use_with !minimal cd-read) \
		$(use_with !minimal iso-info) \
		$(use_with !minimal iso-read) \
		$(use_enable !nocxx cxx) \
		--with-cd-paranoia-name=libcdio-paranoia \
		--disable-vcd-info \
		--disable-dependency-tracking || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS

	# maybe next version is fixed
	if use minimal; then
		rm -f "${D}/usr/$(get_libdir)/pkgconfig/libcdio_cdda.pc"
		rm -f "${D}/usr/include/cdio/cdda.h"
	fi
}

pkg_postinst() {
	ewarn "If you've upgraded from a previous version of ${PN}, you may need to re-emerge"
	ewarn "packages that linked against ${PN} (vlc, vcdimager and more) by running:"
	ewarn "\trevdep-rebuild"
}
