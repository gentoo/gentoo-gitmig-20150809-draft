# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/eq-xmms/eq-xmms-0.7.ebuild,v 1.1 2006/01/16 17:42:39 voxus Exp $

IUSE="sse-filters"

inherit eutils autotools

DESCRIPTION="EQU is a realtime graphical equalizer effect plugin that will equalize almost everything that you play through XMMS, not just the MP3s"
HOMEPAGE="http://equ.sourceforge.net/"
SRC_URI="mirror://sourceforge/equ/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

RDEPEND="media-sound/xmms"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-amd64_support.patch

	export WANT_AUTOMAKE="1.7"
	export WANT_AUTOCONF="2.5"
	eautoreconf
}

src_compile() {
	local myconf

	use sse-filters && {
		myconf="--enable-sse-filters"

		use amd64 && myconf="${myconf} --enable-sse2"
	}

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" libdir=`xmms-config --effect-plugin-dir` install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README README.BSD SKINS TODO
}
