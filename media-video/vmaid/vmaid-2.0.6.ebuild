# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vmaid/vmaid-2.0.6.ebuild,v 1.1 2006/12/03 17:23:08 matsuu Exp $

DESCRIPTION="Video maid is the AVI file editor"
HOMEPAGE="http://vmaid.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/vmaid/22932/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa ao mime win32codecs"

RDEPEND=">=x11-libs/gtk+-2
	ao? ( media-libs/libao )
	!ao? ( alsa? ( >=media-libs/alsa-lib-0.9 ) )
	win32codecs? ( media-libs/win32codecs )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	app-text/scrollkeeper"

#MAKEOPTS="-j1"

src_compile() {
	local myconf

	if use ao ; then
		myconf="${myconf} --with-ao=yes"
	elif use alsa ; then
		myconf="${myconf} --with-alsa=yes"
	fi

	econf \
		$(use_enable mime) \
		$(use_with win32codecs w32) \
		${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS CONTRIBUTORS ChangeLog NEWS README
	dohtml -r doc/{en,ja}
}
