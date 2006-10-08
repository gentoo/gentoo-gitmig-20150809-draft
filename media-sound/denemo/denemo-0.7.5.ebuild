# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.7.5.ebuild,v 1.2 2006/10/08 02:37:25 matsuu Exp $

inherit flag-o-matic

DESCRIPTION="GTK+ graphical music notation editor"
HOMEPAGE="http://denemo.sourceforge.net/"
SRC_URI="mirror://sourceforge/denemo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa"

RDEPEND=">=x11-libs/gtk+-2.0.3
	dev-libs/libxml2
	alsa? ( >=media-libs/alsa-lib-0.9.0 )"

DEPEND="${RDEPEND}
	|| ( dev-util/yacc sys-devel/bison )
	sys-devel/flex
	sys-devel/gettext"

src_compile() {
	append-flags -fpermissive
	econf \
		--enable-gtk2 \
		$(use_enable alsa) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog DESIGN* GOALS NEWS README* TODO
}
