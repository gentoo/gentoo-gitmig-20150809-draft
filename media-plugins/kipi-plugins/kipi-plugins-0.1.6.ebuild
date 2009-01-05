# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-0.1.6.ebuild,v 1.1 2009/01/05 14:54:51 scarabeus Exp $

EAPI=1
inherit kde eutils

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Plugins for the KDE Image Plugin Interface (libkipi)."
HOMEPAGE="http://www.kipi-plugins.org/"
SRC_URI="mirror://sourceforge/kipi/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="calendar opengl gphoto2 ipod tiff"

DEPEND="calendar? ( || ( kde-base/libkcal:3.5 kde-base/kdepim:3.5 ) )
		>=media-libs/libkipi-0.1.5
		>=media-libs/libkexiv2-0.1.5
		>=media-libs/libkdcraw-0.1.4
		gphoto2? ( >=media-libs/libgphoto2-2.3.1 )
		>=media-libs/imlib2-1.1.0
		opengl? ( virtual/opengl )
		tiff? ( >=media-libs/tiff-3.6 )
		>=dev-libs/libxslt-1.1
		ipod? ( >=media-libs/libgpod-0.4.2 )"
RDEPEND="${DEPEND}
		>=media-gfx/imagemagick-6.2.4
		>=media-video/mjpegtools-1.6.0
		media-sound/vorbis-tools
		virtual/mpg123"

need-kde 3.5

LANGS="ar be br ca cs cy da de el en_GB es et fi fr ga gl
	hu is it ja lt ms mt nb nds nl nn pa pl pt pt_BR
	ru rw sk sr sr@Latn sv ta th tr uk zh_CN"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup(){
	if ! built_with_use media-libs/imlib2 X ; then
		eerror "X support is required in media-libs/imlib2 in order to be able"
		eerror "to compile media-plugins/kipi-plugins. Please, re-emerge"
		eerror "media-libs/imlib2 with the 'X' USE flag enabled."
		die
	fi
}

src_unpack() {
	kde_src_unpack

	# remove configure script to trigger its rebuild during kde_src_compile
	rm -f "${S}"/configure

	# Set default for the -S option for images2mpeg to work correctly, bug #208133
	epatch "${FILESDIR}/${PN}-default_chroma_opt.patch"

	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -f "${X}."*
	done
}

src_compile() {
	myconf="$(use_enable calendar)
			$(use_enable gphoto2 kameraklient)
			$(use_enable ipod ipodexport)
			$(use_enable tiff acquireimages)
			$(use_enable tiff rawconverter)
			$(use_enable opengl imageviewer)"
	kde_src_compile all
}
