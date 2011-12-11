# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcalendar/xcalendar-4.0-r1.ebuild,v 1.4 2011/12/11 09:08:19 phajdan.jr Exp $

EAPI=2

inherit eutils multilib

DESCRIPTION="A simple interactive calendar program with a notebook capability"
HOMEPAGE="http://www.freebsd.org/"
SRC_URI="ftp://daemon.jp.FreeBSD.org/pub/FreeBSD-jp/ports-jp/LOCAL_PORTS/${P}+i18n.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="motif"

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-proto/xproto
	x11-misc/gccmakedep
	motif? ( >=x11-libs/openmotif-2.3:0 )"

S=${WORKDIR}/${PN}

src_prepare() {
	use motif && epatch "${FILESDIR}"/${P}-motif-gentoo.diff
	epatch "${FILESDIR}"/${P}-implicits.patch
	sed -e "s:%%XCALENDAR_LIBDIR%%:/usr/$(get_libdir)/xcalendar:" \
		-e "s:/usr/local/X11R5/lib/X11/:/usr/$(get_libdir)/:" \
		-i XCalendar.sed || die
}

src_compile() {
	xmkmf -a
	emake CC="$(tc-getCC)" CDEBUGFLAGS="${CFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}"  || die
}

src_install() {
	dobin xcalendar || die
	newman xcalendar.man xcalendar.1 || die

	dodir /etc/X11/app-defaults
	insinto /etc/X11/app-defaults
	newins XCalendar.sed XCalendar || die

	insinto /usr/$(get_libdir)/xcalendar
	doins *.xbm *.hlp || die

	dodoc README || die
}
