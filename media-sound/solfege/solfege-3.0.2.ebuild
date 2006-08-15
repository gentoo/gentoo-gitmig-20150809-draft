# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/solfege/solfege-3.0.2.ebuild,v 1.2 2006/08/15 22:01:28 wormo Exp $

IUSE="alsa oss"

inherit python eutils

DESCRIPTION="GNU Solfege is a program written to help you practice ear training."
HOMEPAGE="http://www.solfege.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=dev-lang/python-2.3
	>=x11-libs/gtk+-2.4.0
	>=dev-python/pygtk-2.4.0
	>=dev-python/gnome-python-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	=dev-lang/swig-1.3*
	sys-devel/gettext
	sys-apps/texinfo
	dev-libs/libxslt
	sys-apps/sed"

src_compile() {
	econf `use_enable oss oss-sound` || die "Configuration failed."
	emake || die "Compilation failed."
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed."

	dodoc AUTHORS changelog FAQ README TODO
}

pkg_postinst() {
	einfo "If you plan to play sounds using an external midiplayer, or if you"
	einfo "get other error messages that you think might be caused by your"
	einfo "sound setup or Solfeges sound code, then you should start the program"
	einfo "with the '--no-sound' command line option the first time you run the"
	einfo "program, and then configure sound from the preferences window."
}
