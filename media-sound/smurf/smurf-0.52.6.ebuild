# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/smurf/smurf-0.52.6.ebuild,v 1.11 2006/11/05 20:54:26 aballier Exp $

inherit eutils

DESCRIPTION="The Smurf Sound Font Editor"
HOMEPAGE="http://smurf.sourceforge.net/"
SRC_URI="mirror://sourceforge/smurf/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

IUSE="nls debug alsa oss png"

RDEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/audiofile-0.2.3-r1
	nls? ( virtual/libintl )
	alsa? ( media-libs/alsa-lib )
	png? ( >=media-libs/libpng-1.2.5-r4 )"

DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.5-r1 )"

src_compile() {
	epatch "${FILESDIR}/${P}-gcc4.patch"
	local myconf="--with-audiofile"
	use nls || myconf="${myconf} --disable-nls"
	use debug || myconf="${myconf} --disable-debug"
	# --disable-debug seems not to work, but never mind
	use alsa || myconf="${myconf} --disable-alsa-support"
	use oss || myconf="${myconf} --disable-oss-support"
	use png || myconf="${myconf} --disable-splash"
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog HACKING NEWS README
}
