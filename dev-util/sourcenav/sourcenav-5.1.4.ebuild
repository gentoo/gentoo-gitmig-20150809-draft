# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.1.4.ebuild,v 1.12 2008/02/10 22:39:36 nerdboy Exp $

inherit eutils libtool toolchain-funcs flag-o-matic

S=${WORKDIR}/build

DESCRIPTION="Source-Navigator is a source code analysis and development tool"
SRC_URI="mirror://sourceforge/sourcenav/${P}.tar.gz mirror://gentoo/${P}-gentoo.diff.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 sparc ppc ppc64 x86"
IUSE=""
SN="/opt/sourcenav"

RDEPEND="x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXaw
	sys-libs/glibc"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	mkdir "${WORKDIR}"/build
	cd "${WORKDIR}/${P}"
	epatch "${FILESDIR}"/${PN}-5.2_beta2-tk-size.patch
	epatch "${DISTDIR}"/${PF}-gentoo.diff.gz
	epatch "${FILESDIR}"/${P}-bash3.patch
	# Backported from 5.2
	if [ $(gcc-major-version) -ge 4 ]; then
	    epatch "${FILESDIR}"/${P}-gcc4.patch || die "gcc4 patch failed"
	fi
}

src_compile() {
	cd "${WORKDIR}"/build
	../${P}/configure \
		--host="${CHOST}" \
		--prefix="${SN}" \
		--exec-prefix="${SN}" \
		--bindir="${SN}"/bin \
		--sbindir="${SN}"/sbin \
		--mandir="${SN}"/share/man \
		--infodir="${SN}"/share/info \
		--datadir="${SN}"/share \
		--libdir="${SN}"/$(get_libdir) || die "configure failed"

	make || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	chmod -Rf 755 "${D}/${SN}"/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > "${D}"/etc/env.d/10snavigator
}
