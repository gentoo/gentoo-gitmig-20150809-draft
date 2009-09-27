# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-connection-managers/telepathy-connection-managers-1.ebuild,v 1.1 2009/09/27 17:59:37 tester Exp $

DESCRIPTION="Meta-package for Telepathy Connection Managers"

HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI=""
LICENSE="as-is"
SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE="msn irc yahoo icq jabber sip bonjour"

DEPEND=""
RDEPEND="msn? ( net-voip/telepathy-butterfly )
	jabber? ( net-voip/telepathy-gabble )
	sip? ( net-voip/telepathy-sofiasip )
	bonjour? ( net-voip/telepathy-salut )
	icq? ( net-voip/telepathy-haze )
	yahoo? ( net-voip/telepathy-haze )"
