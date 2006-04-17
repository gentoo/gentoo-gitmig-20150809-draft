# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gsubedit/gsubedit-0.4_pre1-r2.ebuild,v 1.2 2006/04/17 13:48:19 flameeyes Exp $

inherit eutils

DESCRIPTION="A tool for editing and converting DivX ;-) subtitles"
HOMEPAGE="http://gsubedit.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1.2*
		=gnome-base/gnome-libs-1*
		nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P/_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/crashes.patch"
	epatch "${FILESDIR}/${P}-oveflow.patch"
	epatch "${FILESDIR}/${P}-desktop.patch"
}

src_compile() {
	econf $(use_with nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} gsubeditdocdir=/usr/share/doc/${PF} install \
		|| die "make install failed"
}
