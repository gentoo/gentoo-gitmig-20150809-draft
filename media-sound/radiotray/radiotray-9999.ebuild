# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/radiotray/radiotray-9999.ebuild,v 1.5 2010/06/23 17:44:04 hwoarang Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit mercurial distutils

DESCRIPTION="Online radio streaming player"
HOMEPAGE="http://radiotray.sourceforge.net/"
SRC_URI=""
EHG_REPO_URI="http://radiotray.hg.sourceforge.net/hgweb/radiotray/"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS=""
IUSE=""

LANGS="ca de el en_GB es fi fr gl gu hu it ko lt pl pt_BR pt ro ru sk sl sv te
tr uk zh_CN"

for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

RDEPEND="dev-python/gst-python
	dev-python/pygtk
	dev-python/lxml
	dev-python/pyxdg
	dev-python/pygobject
	dev-python/notify-python
	media-libs/gst-plugins-good
	media-libs/gst-plugins-ugly
	media-plugins/gst-plugins-alsa
	media-plugins/gst-plugins-libmms
	media-plugins/gst-plugins-ffmpeg
	media-plugins/gst-plugins-mad
	media-plugins/gst-plugins-ogg
	media-plugins/gst-plugins-soup
	media-plugins/gst-plugins-vorbis"

DEPEND="${RDEPEND}"

DOCS="AUTHORS CONTRIBUTORS NEWS README"

S="${WORKDIR}"/${PN}

src_prepare() {
	python_convert_shebangs -r 2 .
	distutils_src_prepare
	# remove LINUGAS file so we can create our
	rm "${S}"/po/LINGUAS
	for x in ${LANGS}; do
		use "linguas_${x}" && echo "${x}" >> "${S}"/po/LINGUAS
		! use "linguas_${x}" && rm "${S}"/po/${x}.po
	done
}
