# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.4.10_p20090130.ebuild,v 1.1 2009/01/30 15:35:30 carlo Exp $

ARTS_REQUIRED="never"

LANGS="af ar az be bg bn br ca cs cy da de el en_GB eo es et eu fa fi
fr ga gl he hi hu id is it ja km ko ku lo lt mk ms nb nds ne nl nn pa
pl pt pt_BR ro ru rw se sk sl sq sr sr@Latn ss sv ta tg th tr uk uz
zh_CN zh_TW"

LANGS_DOC="da de es et fr it nl pl pt pt_BR ru sv"

USE_KEG_PACKAGING=1

inherit kde

PKG_SUFFIX=""

MY_P="${P/_*/}"
S="${WORKDIR}/${MY_P}"

SRC_URI="mirror://kde/stable/amarok/${PV/_*/}/src/${MY_P}.tar.bz2
	mirror://gentoo/amarok-1.4.10-post20090130.diff.tar.bz2"

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="mp4 kde mysql amazon opengl postgres
visualization ipod ifp real njb mtp musicbrainz daap
python"
# kde: enables compilation of the konqueror sidebar plugin

RDEPEND="kde? ( || ( =kde-base/konqueror-3.5* =kde-base/kdebase-3.5* ) )
	>=media-libs/xine-lib-1.1.2_pre20060328-r8
	>=media-libs/taglib-1.4
	mysql? ( >=virtual/mysql-4.0 )
	postgres? ( virtual/postgresql-base )
	opengl? ( virtual/opengl )
	visualization? ( media-libs/libsdl
		=media-plugins/libvisual-plugins-0.4* )
	ipod? ( >=media-libs/libgpod-0.5.2 )
	mp4? ( media-libs/libmp4v2 )
	ifp? ( media-libs/libifp )
	real? (
		media-video/realplayer
		media-libs/alsa-lib )
	njb? ( >=media-libs/libnjb-2.2.4 )
	mtp? ( <media-libs/libmtp-0.3.0 )
	musicbrainz? ( media-libs/tunepimp )
	=dev-lang/ruby-1.8*"

DEPEND="${RDEPEND}"

RDEPEND="${RDEPEND}
	app-arch/unzip
	python? ( dev-python/PyQt )
	daap? ( www-servers/mongrel )"

PATCHES=( "${FILESDIR}/amarok-1.4.10-gcc-4.3.patch"
	"${WORKDIR}/amarok-1.4.10-post20090130.diff"
	"${WORKDIR}/amarok-1.4.10-desktop-entry.diff" )

need-kde 3.5

src_compile() {
	# Extra, unsupported engines are forcefully disabled.
	local myconf="$(use_enable mysql) $(use_enable postgres postgresql)
				  $(use_with opengl)
				  $(use_with visualization libvisual)
				  $(use_enable amazon)
				  $(use_with ipod libgpod)
				  $(use_with mp4 mp4v2)
				  $(use_with ifp)
				  $(use_with real helix)
				  $(use_with njb libnjb)
				  $(use_with mtp libmtp)
				  $(use_with musicbrainz)
				  $(use_with daap)
				  --with-xine
				  --without-nmm"

	kde_src_compile
}

src_install() {
	kde_src_install

	# As much as I respect Ian, I'd rather leave Amarok to use mongrel
	# from Portage, for security and policy reasons.
	rm -rf "${D}"/usr/share/apps/amarok/ruby_lib/rbconfig \
		"${D}"/usr/share/apps/amarok/ruby_lib/mongrel* \
		"${D}"/usr/share/apps/amarok/ruby_lib/rubygems* \
		"${D}"/usr/share/apps/amarok/ruby_lib/gem* \
		"${D}"/usr/$(get_libdir)/ruby_lib

	if ! use python; then
		rm -r "${D}"/usr/share/apps/amarok/scripts/webcontrol \
			|| die "Unable to remove webcontrol."
	fi
}
