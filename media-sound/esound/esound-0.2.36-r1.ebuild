# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.36-r1.ebuild,v 1.5 2005/08/26 17:48:22 gustavoz Exp $

inherit libtool gnome.org eutils

DESCRIPTION="The Enlightened Sound Daemon"
HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc-macos ~ppc64 sparc x86"
IUSE="alsa debug ipv6 static tcpd"

# esound comes with arts support, but it hasn't been tested yet, feel free to
# submit patches/improvements
DEPEND=">=media-libs/audiofile-0.1.5
	alsa? ( >=media-libs/alsa-lib-0.5.10b )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"
#	arts? ( kde-base/arts )

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.2.32-amd64.patch
	use ppc-macos && epatch ${FILESDIR}/${PN}-0.2.35-ppc-macos.patch
}

src_compile() {
	local myconf="--sysconfdir=/etc/esd $(use_enable ipv6) \
		$(use_enable static) $(use_enable debug debugging) $(use_enable alsa) \
		$(use_with tcpd libwrap)"

	elibtoolize

	econf $myconf || die "Configure failed"

	make || die "Make failed"
}

src_install() {

	make DESTDIR="${D}" install  || die "Installation failed"

	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README TIPS TODO

	[ -d "docs/html" ] && dohtml -r docs/html/*

	newconfd ${FILESDIR}/esound.conf.d esound

	extradepend=""
	use tcpd && extradepend=" portmap"
	use alsa && extradepend="$extradepend alsasound"
	sed "s/@extradepend@/$extradepend/" <${FILESDIR}/esound.init.d >${T}/esound
	doinitd ${T}/esound

}
