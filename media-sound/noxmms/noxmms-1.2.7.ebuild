# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noxmms/noxmms-1.2.7.ebuild,v 1.3 2004/04/01 07:47:11 eradicator Exp $

DESCRIPTION="a stripped down (command line only) version of XMMS."
HOMEPAGE="http://xmmsd.sourceforge.net/noxmms/"
SRC_URI="http://xmmsd.sourceforge.net/noxmms/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc ~sparc"
IUSE="oggvorbis esd 3dnow nls"
DEPEND="oggvorbis? ( media-libs/libvorbis )
	esd? ( media-sound/esound )"

RDEPEND="${DEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_enable oggvorbis vorbis` \
		`use_enable esd` \
		`use_enable nls` \
		`use_enable 3dnow` \
		|| die
	emake || die
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog FAQ NEWS README README.noxmms TODO
}

pkg_postinst() {
	einfo "If you do not plan on installing xmms, you may want to setup the following symlink before"
	einfo "installing xmms plugins."
	einfo "/usr/bin/xmms-config -> /usr/bin/xmms-config"
}
