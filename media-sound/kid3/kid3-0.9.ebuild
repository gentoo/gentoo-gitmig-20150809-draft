# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-0.9.ebuild,v 1.1 2007/06/23 23:57:25 philantrop Exp $

inherit kde

DESCRIPTION="A simple ID3 tag editor for QT/KDE."
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="flac taglib vorbis"

DEPEND=">=media-libs/id3lib-3.8.3
	taglib? ( >=media-libs/taglib-1.4-r1 )
	vorbis? ( media-libs/libvorbis )
	flac? ( media-libs/flac )"

need-kde 3

LANGS="de es fr ru"
LANGS_DOC="de en"

for X in ${LANGS} ${LANGS_DOC} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}.po"
	done
	sed -i -e "s:POFILES =.*:POFILES = ${MAKE_LANGS}:" Makefile.am

	MAKE_LANGS=""
	cd "${WORKDIR}/${P}/doc"
	for X in ${LANGS_DOC} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done
	sed -i -e "s:SUBDIRS =.*:SUBDIRS = ${MAKE_LANGS}:" Makefile.am
	rm -f ${S}/configure
}

# Support for the KDE libraries is optional,
# but the configure step that detects them
# cannot be avoided. So KDE support is forced on.

src_compile() {
	local myconf="--with-kde
				$(use_with vorbis)
				$(use_with flac)
				$(use_with taglib)
				--without-musicbrainz"

	kde_src_compile
}
