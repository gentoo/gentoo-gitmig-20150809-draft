# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ripperx/ripperx-2.7.1.ebuild,v 1.2 2008/01/19 21:47:45 mr_bones_ Exp $

inherit eutils toolchain-funcs

MY_P=${P/x/X}-gtk2
MY_PN=${PN/x/X}

DESCRIPTION="RipperX is a program to rip CD and encode mp3s"
HOMEPAGE="http://www.thewildbeast.co.uk/wordpress/2007/05/21/ripperx-gtk2"
SRC_URI="http://www.thewildbeast.co.uk/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2
	media-sound/lame
	media-sound/cdparanoia
	media-libs/id3lib
	media-libs/flac"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_compile() {
	tc-export CC
	econf $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	dobin src/${MY_PN} \
	plugins/${MY_PN}_plugin{-8hz-mp3,-bladeenc,-cdparanoia,-encode,-flac,-gogo,-l3enc,-lame,-mp3enc,-oggenc,_tester,-toolame,-xingmp3enc}

	dodoc CHANGES README TODO

	doicon src/xpms/${MY_PN}-icon.xpm
	make_desktop_entry ${MY_PN} ${MY_PN} ${MY_PN}-icon
}

pkg_postinst() {
	elog "Original ${MY_PN} can be found from http://ripperx.sf.net, this is a"
	elog "unofficial patch release adding GTK+-2 support. Continue reading.."
	elog "And as of now, 20080119, in portage as ~media-sound/${PN}-2.7.0."
}
