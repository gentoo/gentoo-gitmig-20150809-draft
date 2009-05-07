# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/k3guitune/k3guitune-1.01.ebuild,v 1.2 2009/05/07 07:42:00 fauli Exp $

inherit kde eutils

DESCRIPTION="A program for KDE that lets you tune musical instruments."
HOMEPAGE="http://home.planet.nl/~lamer024/k3guitune.html"
SRC_URI="http://home.planet.nl/~lamer024/files/${P}.tar.gz
		mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="alsa oss jack"

DEPEND="=sci-libs/fftw-3*
	alsa? ( media-libs/alsa-lib )
	jack? ( media-libs/bio2jack )"
RDEPEND="${DEPEND}"

need-kde 3.5

LANGS="de fr nl sk"
LANGS_DOC="de en nl"

for X in ${LANGS} ${LANGS_DOC} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${PN}-1.0-gcc43.patch \
		"${FILESDIR}"/${P}-fftw.patch

	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}.po"
	done
	cd "${S}/po"
	sed -i -e "s:POFILES =.*:POFILES = ${MAKE_LANGS}:" Makefile.am \
		|| die "sed for translations failed"

	MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | tr ' ' '\n' | sort | uniq -d))
	[[ -n ${MAKE_DOC} ]] && MAKE_DOC=$(echo "${MAKE_DOC}" | tr '\n' ' ')
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_DOC} :" \
		"${KDE_S}/doc/Makefile.am" || die "sed for docs locale failed"

	rm -f "${S}/configure"
}

src_compile() {
	local myconf="$(use_enable alsa)
		$(use_enable arts)
		$(use_enable oss)
		$(use_enable jack)"

	kde_src_compile
}
