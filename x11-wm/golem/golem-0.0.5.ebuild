# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/golem/golem-0.0.5.ebuild,v 1.3 2003/07/31 01:46:03 matsuu Exp $

DESCRIPTION="Small window manager with themes and plugins"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://golem.sourceforge.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="nls"

DEPEND="virtual/glibc
	virtual/x11"

S="${WORKDIR}/${P}"

src_compile() {
	local myconf
	use nls && myconf="${myconf} --enable-i18n"

	econf \
		--prefix=/usr \
		--datadir=/usr/share \
		${myconf} || die

	emake || die
}

src_install() {
	einstall || die

	dosed "s/BINDIR=	*/BINDIR=/" /usr/bin/golem.install
	dosed "s/DATADIR=	*/DATADIR=/" /usr/bin/golem.install

	dodoc LICENSE PLUGINS README THEMES TODO

	einfo "The user you intend to use golem as (not root!!),"
	einfo "just type golem.install"
}

