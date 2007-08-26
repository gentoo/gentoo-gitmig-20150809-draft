# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/purple-plugin_pack/purple-plugin_pack-1.0.ebuild,v 1.5 2007/08/26 12:44:00 philantrop Exp $

MY_P="$PN-${PV}"

DESCRIPTION="A package with many different plugins for pidgin and libpurple"
HOMEPAGE="http://plugins.guifications.org"
SRC_URI="http://downloads.guifications.org/plugins/Plugin%20Pack/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa x86"
PLUGINS="autorejoin awaynotify bashorg bit blistops dice difftopic eight_ball
flip gRIM groupmsg irssi lastseen listhandler mystatusbox nicksaid oldlogger
plonkers sepandtab showoffline simfix slashexec sslinfo xchat-chats"
IUSE="talkfilters debug"

DEPEND="net-im/pidgin
	talkfilters? ( app-text/talkfilters )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	# XMMS Remote is disabled due to XMMS being masked
	#
	# Disabled due to non-working status:
	# buddytime
	# chronic
	# Stocker (http://plugins.guifications.org/trac/wiki/stocker)
	#
	# Disabled due to being included in current pidgin release:
	# Auto Accept
	# Auto Reply
	# Buddy Note
	# convcolors
	# Marker Line
	# New Line
	# Offline Message

	local plugins=${PLUGINS}

	use talkfilers && plugins="${plugins},talkfilters"

	econf --with-plugins="${plugins}" $(use_enable debug) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO VERSION
}
