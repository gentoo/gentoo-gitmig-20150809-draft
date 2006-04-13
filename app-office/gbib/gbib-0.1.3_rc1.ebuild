# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gbib/gbib-0.1.3_rc1.ebuild,v 1.4 2006/04/13 05:15:02 tsunam Exp $

inherit eutils

MY_PV=${PV/_/}

DESCRIPTION="user-friendly editor and browser for BibTeX bibliographic databases"
HOMEPAGE="http://gbib.seul.org/"
SRC_URI="http://gbib.seul.org/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 sparc x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1.2*
	=gnome-base/gnome-libs-1.4*"
DEPEND="${RDEPEND}
	virtual/tetex"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-Makefile.patch || die
}

src_compile() {
	econf `use_with nls` || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ABOUT-NLS AUTHORS CHANGES README TODO || die
	make_desktop_entry gbib	"gBib BibTeX Editor" \
		/usr/share/gbib/gbib48.xpm "Application;Office;"
}

pkg_postinst() {
	einfo
	einfo "To insert citations in a LyX document, verify that LyX"
	einfo "is running before clicking on the lyx button."
	einfo "The LyX server must be enabled, just add in your"
	einfo "lyxrc this line:"
	einfo
	einfo "	\serverpipe \"/YOUR_HOME_DIR/.lyxpipe\""
	einfo
}
