# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/npapi-vlc/npapi-vlc-9999.ebuild,v 1.2 2011/09/21 08:43:31 mgorny Exp $

EAPI=3

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then
	SCM=git-2
	EGIT_BOOTSTRAP=""
	EGIT_REPO_URI="git://git.videolan.org/${PN}.git"
fi

inherit autotools multilib ${SCM}

DESCRIPTION="Mozilla plugin based on VLC"
HOMEPAGE="http://www.videolan.org/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"

if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="~amd64"
else
	KEYWORDS=""
fi
IUSE=""

RDEPEND=">=media-video/vlc-1.1
	>=net-libs/xulrunner-1.9.2
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXt
	!<media-video/vlc-1.2[nsplugin]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	if [ "${PV%9999}" != "${PV}" ] ; then
		eautoreconf
	fi
}

src_install() {
	emake DESTDIR="${D}" npvlcdir="/usr/$(get_libdir)/nsbrowser/plugins" install || die
	find "${D}" -name '*.la' -delete
	dodoc NEWS AUTHORS ChangeLog || die
}
