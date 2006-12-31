# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-9999.ebuild,v 1.2 2006/12/31 12:56:45 flameeyes Exp $

inherit kde subversion

ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/extragear/multimedia/amarok"
ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/svn-src/"

PKG_SUFFIX=""

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="-*"
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
	mtp? ( >=media-libs/libmtp-0.1.0 )
	musicbrainz? ( media-libs/tunepimp )
	=dev-lang/ruby-1.8*"

DEPEND="${RDEPEND}"

need-kde 3.3

S="${WORKDIR}/${PN}"

src_unpack() {
	ESVN_UPDATE_CMD="svn update -N" \
	ESVN_FETCH_CMD="svn checkout -N" \
	ESVN_REPO_URI=`dirname ${ESVN_REPO_URI}` \
		subversion_src_unpack

	S="${WORKDIR}/${PN}/admin" \
	ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/branches/KDE/3.5/kde-common/admin" \
		subversion_src_unpack

	ESVN_UPDATE_CMD="svn up" \
	ESVN_FETCH_CMD="svn checkout" \
	S="${WORKDIR}/${PN}/amarok" \
		subversion_src_unpack
}

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
