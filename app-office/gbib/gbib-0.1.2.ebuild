# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gbib/gbib-0.1.2.ebuild,v 1.2 2004/04/07 18:48:20 vapier Exp $

inherit eutils

DESCRIPTION="user-friendly editor and browser for BibTeX bibliographic databases"
HOMEPAGE="http://gbib.seul.org/"
SRC_URI="ftp://ftp.seul.org/pub/gbib/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1.2*
	=gnome-base/gnome-libs-1.4*"
DEPEND="${RDEPEND}
	virtual/tetex"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SINGLE_MSG="Applying gentoo gBib patches" \
	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_compile() {
	econf `use_with nls` || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ABOUT-NLS AUTHORS CHANGES INSTALL README TODO || die
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
