# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sndfile/xmms-sndfile-1.2.ebuild,v 1.16 2006/07/05 06:08:34 vapier Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="a libsndfile plugin for XMMS"
HOMEPAGE="http://www.mega-nerd.com/xmms_sndfile/"
SRC_URI="http://www.mega-nerd.com/xmms_sndfile/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND="media-libs/libsndfile
	media-sound/xmms"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" libdir="$(xmms-config --input-plugin-dir)" install || die
	dodoc AUTHORS NEWS README ChangeLog TODO
}
