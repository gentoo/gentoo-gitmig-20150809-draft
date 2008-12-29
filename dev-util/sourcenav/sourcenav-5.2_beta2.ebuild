# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.2_beta2.ebuild,v 1.12 2008/12/29 23:24:26 nerdboy Exp $

inherit autotools flag-o-matic eutils toolchain-funcs fdo-mime

MY_P="5.2b2"
S=${WORKDIR}/sourcenav-${MY_P}
SB=${WORKDIR}/snbuild
SN="/opt/sourcenav"

DESCRIPTION="Source-Navigator is a source code analysis and software development tool"
SRC_URI="mirror://sourceforge/sourcenav/sourcenav-${MY_P}.tar.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~sparc ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXaw
	sys-libs/glibc"

DEPEND="${RDEPEND}
	x11-proto/xproto"

WANT_AUTOCONF="2.5"
AT_M4DIR="${S}/config"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}_destdir.patch
	epatch "${FILESDIR}"/${P}-tk-size.patch
	sed -i -e "s/relid'/relid/" tcl/unix/configure
	sed -i -e "s/relid'/relid/" tk/unix/configure
	# Bug 131412
	if [ $(gcc-major-version) -ge 4 ]; then
	    epatch "${FILESDIR}"/${P}-gcc4.patch
	fi

	# update internal tk (see bugs 225999 and 252700
	epatch "${FILESDIR}"/${PN}_tk-8.3-lastevent.patch
	eaclocal
}

src_compile() {
	append-flags -DHAVE_STDLIB_H=1 -D_GNU_SOURCE=1
	sh ./configure "${MY_CONF}" \
		--host="${CHOST}" \
		--prefix="${SN}" \
		--bindir="${SN}"/bin \
		--sbindir="${SN}"/sbin \
		--exec-prefix="${SN}" \
		--mandir="${SN}"/share/man \
		--infodir="${SN}"/share/info \
		--datadir="${SN}"/share \
		$(use_enable debug symbols) || die "configure failed"

	make all || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	chmod -Rf 755 "${D}/${SN}/share/doc/${P}/demos"
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > "${D}"/etc/env.d/10snavigator

	make_desktop_entry \
	    /opt/sourcenav/bin/snavigator \
	    "Source Navigator ${PV}" \
	    "/opt/sourcenav/share/bitmaps/ide_icon.xpm" \
	    "Application;Development"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
