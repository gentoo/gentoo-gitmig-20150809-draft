# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.5.0_pre040506.ebuild,v 1.9 2005/05/05 02:47:10 vapier Exp $

inherit eutils

MY_P="${P%_pre*}"	# 0.5.0_pre040506 -> 0.5.0

S="${WORKDIR}/${MY_P}"
DESCRIPTION="Window manager based on BlackBox"
# Temporary URL until SF's CVS is back online
SRC_URI="http://www.cs.umu.se/~c99drn/waimea/${P/_pre/-}.tar.gz"
HOMEPAGE="http://www.waimea.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="truetype xinerama svg"

DEPEND="virtual/x11
	>=x11-libs/cairo-0.1.22
	svg? ( x11-libs/libsvg-cairo )"

PROVIDE="virtual/blackbox"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_P}-64bit-clean.patch
	epatch ${FILESDIR}/${MY_P}-font.patch
	if has_version '>=x11-libs/cairo-0.3' ; then
		epatch ${FILESDIR}/${MY_P}-includes.patch
	fi
}

src_compile() {
	econf \
		`use_enable xinerama` \
		`use_enable truetype xft` \
		`use_enable svg ` \
		--enable-shape \
		--enable-render \
		--enable-randr \
		--enable-pixmap \
		|| die
	emake || die
}

src_install() {
	einstall sysconfdir=${D}/etc/X11/waimea || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS

	exeinto /etc/X11/Sessions
	echo "/usr/bin/waimea" > waimea
	doexe waimea
}

pkg_postinst() {
	einfo "Please read the README in /usr/share/doc/${PF}"
	einfo "for info on setting up and configuring waimea"
}
