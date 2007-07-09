# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.8.1.ebuild,v 1.1 2007/07/09 18:10:22 aballier Exp $

inherit eutils

DESCRIPTION="wavbreaker/wavmerge GTK2 utility to break or merge WAV file"
HOMEPAGE="http://wavbreaker.sourceforge.net/"
SRC_URI="mirror://sourceforge/wavbreaker/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -sparc ~x86"
IUSE="alsa oss"

RDEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}"

src_compile() {
	econf $(use_enable alsa)\
		$(use_enable oss) || die "configuration failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS CONTRIBUTORS ChangeLog NEWS README TODO
}
