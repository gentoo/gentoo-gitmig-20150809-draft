# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.4.4-r4.ebuild,v 1.2 2007/01/31 14:01:19 gustavoz Exp $

LANGS="af ar az bg br ca cs cy da de el en_GB es et fi fr ga gl he hi hu is it
ja ka km ko lt ms nb nl nn pa pl pt pt_BR ro ru rw sk sl sq sr sr@Latn sv ta tg
th tr uk uz zh_CN zh_TW"
LANGS_DOC="da de es et fr it nl pl pt pt_BR ru sv"

USE_KEG_PACKAGING=1

inherit kde eutils flag-o-matic

PKG_SUFFIX=""

MY_P="${P/_/-}"
S="${WORKDIR}/${P/_/-}"

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

SRC_URI="mirror://kde/stable/amarok/${PV}/src/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd"
IUSE="aac kde mysql noamazon opengl postgres
visualization ipod ifp real njb mtp musicbrainz"
# kde: enables compilation of the konqueror sidebar plugin

RDEPEND="kde? ( || ( kde-base/konqueror kde-base/kdebase ) )
	>=media-libs/xine-lib-1.1.2_pre20060328-r8
	>=media-libs/taglib-1.4
	mysql? ( >=virtual/mysql-4.0 )
	postgres? ( dev-db/libpq )
	opengl? ( virtual/opengl )
	visualization? ( media-libs/libsdl
					 =media-plugins/libvisual-plugins-0.4* )
	ipod? ( >=media-libs/libgpod-0.3 )
	aac? ( media-libs/libmp4v2 )
	ifp? ( media-libs/libifp )
	real? ( media-video/realplayer )
	njb? ( >=media-libs/libnjb-2.2.4 )
	mtp? ( media-libs/libmtp )
	musicbrainz? ( media-libs/tunepimp )
	=dev-lang/ruby-1.8*"

DEPEND="${RDEPEND}"

RDEPEND="${RDEPEND}
	www-servers/mongrel"

need-kde 3.3

PATCHES="${WORKDIR}/${P}-gentoo/*.patch
	${FILESDIR}/${P}+libgpod-0.4.0.patch"

src_compile() {
	# Extra, unsupported engines are forcefully disabled.
	local myconf="$(use_enable mysql) $(use_enable postgres postgresql)
				  $(use_with opengl) --without-xmms
				  $(use_with visualization libvisual)
				  $(use_enable !noamazon amazon)
				  $(use_with ipod libgpod)
				  $(use_with aac mp4v2)
				  $(use_with ifp)
				  $(use_with real helix)
				  $(use_with njb libnjb)
				  $(use_with mtp libmtp)
				  $(use_with musicbrainz)
				  --with-xine
				  --without-mas
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
}
