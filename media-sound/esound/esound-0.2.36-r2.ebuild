# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.36-r2.ebuild,v 1.18 2006/10/22 21:25:36 kloeri Exp $

WANT_AUTOMAKE=1.8
inherit libtool gnome.org eutils autotools flag-o-matic

DESCRIPTION="The Enlightened Sound Daemon"
HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc-macos ppc64 sparc ~x86 ~x86-fbsd"
IUSE="alsa debug ipv6 tcpd"

# esound comes with arts support, but it hasn't been tested yet, feel free to
# submit patches/improvements
DEPEND=">=media-libs/audiofile-0.1.5
	alsa? ( >=media-libs/alsa-lib-0.5.10b )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"
#	arts? ( kde-base/arts )

RDEPEND="${DEPEND}
	app-admin/eselect-esd"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-0.2.32-amd64.patch"
	# please note, this is a conditional, version specific patch!!!
	# when bumping avoid bugs like #103969
	use ppc-macos && epatch "${FILESDIR}/${P}-ppc-macos.patch"

	epatch "${FILESDIR}/${P}-mode_t.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"


	AT_M4DIR="m4" eautomake

	elibtoolize
}

src_compile() {
	# Strict aliasing problem
	append-flags -fno-strict-aliasing

	econf \
		--sysconfdir=/etc/esd \
		$(use_enable ipv6) \
		$(use_enable debug debugging) \
		$(use_enable alsa) \
		$(use_with tcpd libwrap) \
		--disable-dependency-tracking \
		|| die "Configure failed"

	emake || die "Make failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install  || die "Installation failed"
	mv "${D}/usr/bin/"{esd,esound-esd}

	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README TIPS TODO

	[[ -d "docs/html" ]] && dohtml -r docs/html/*

	newconfd "${FILESDIR}/esound.conf.d" esound

	extradepend=""
	use tcpd && extradepend=" portmap"
	use alsa && extradepend="$extradepend alsasound"
	sed -e "s/@extradepend@/$extradepend/" "${FILESDIR}/esound.init.d.2" >"${T}/esound"
	doinitd "${T}/esound"
}

pkg_postinst() {
	eselect esd update --if-unset
}
