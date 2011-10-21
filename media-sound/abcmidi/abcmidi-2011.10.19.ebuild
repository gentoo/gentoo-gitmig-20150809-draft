# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcmidi/abcmidi-2011.10.19.ebuild,v 1.2 2011/10/21 20:18:20 radhermit Exp $

EAPI="4"

inherit eutils versionator

MY_P="abcMIDI-$(replace_all_version_separators '-')"
DESCRIPTION="Programs for processing ABC music notation files"
HOMEPAGE="http://abc.sourceforge.net/abcMIDI/"
SRC_URI="http://ifdo.pugmarks.com/~seymour/runabc/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="app-arch/unzip"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch
	rm makefile || die
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc doc/{AUTHORS,CHANGES,abcguide.txt,abcmatch.txt,history.txt,readme.txt,yapshelp.txt}

	if use examples ; then
		docinto examples
		dodoc samples/*.abc
	fi
}
