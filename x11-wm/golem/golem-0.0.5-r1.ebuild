# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/golem/golem-0.0.5-r1.ebuild,v 1.4 2004/04/06 03:18:42 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Small window manager with themes and plugins"
HOMEPAGE="http://golem.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
IUSE="nls xinerama esd"

DEPEND="virtual/glibc
	virtual/x11
	esd? ( media-sound/esound )"

src_compile() {
	use amd64 && append-flags -fPIC
	econf \
		`use_enable nls i18n` \
		`use_enable esd sound` \
		`use_enable xinerama` || die
	emake || die
}

src_install() {
	einstall || die

	dosed "s/\(\(BIN\|DATA\)DIR=\)[[:space:]]*/\1/" /usr/bin/golem.install

	dodir /etc/X11/Sessions
	echo "/usr/bin/golem" > ${D}/etc/X11/Sessions/golem
	fperms a+x /etc/X11/Sessions/golem

	dodoc ChangeLog PLUGINS README THEMES TODO
}

pkg_postinst() {
	einfo "The user you intend to use golem as (not root!!),"
	einfo "just type golem.install"
}
