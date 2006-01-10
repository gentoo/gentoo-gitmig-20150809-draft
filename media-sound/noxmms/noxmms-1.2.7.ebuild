# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noxmms/noxmms-1.2.7.ebuild,v 1.8 2006/01/10 09:40:54 jer Exp $


DESCRIPTION="a stripped down (command line only) version of XMMS."
HOMEPAGE="http://xmmsd.sourceforge.net/noxmms/"
SRC_URI="http://xmmsd.sourceforge.net/noxmms/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc sparc"
IUSE="vorbis esd 3dnow nls"

DEPEND="=dev-libs/glib-1.2*
	vorbis? ( media-libs/libvorbis )
	esd? ( media-sound/esound )"
RDEPEND="${DEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		$(use_enable vorbis) \
		$(use_enable esd) \
		$(use_enable nls) \
		$(use_enable 3dnow) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog FAQ NEWS README README.noxmms TODO
}

pkg_postinst() {
	einfo "If you do not plan on installing xmms, you may want to setup the following symlink before"
	einfo "installing xmms plugins."
	einfo "/usr/bin/noxmms-config -> /usr/bin/xmms-config"
}
