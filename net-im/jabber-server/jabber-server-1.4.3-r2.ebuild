# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabber-server/jabber-server-1.4.3-r2.ebuild,v 1.1 2004/01/26 14:21:41 humpback Exp $

DESCRIPTION="Open Source Jabber Server & JUD,MUC,AIM,MSN,ICQ and Yahoo transports"
HOMEPAGE="http://www.jabber.org"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

pkg_postinst() {
	ewarn "net-im/jabber-server is no longer available"
	einfo "You need to use net-im/jabberd and the various transports"
	einfo "net-im/jit - ICQ transport (You can use aim-transport for icq but JIT is better)"
	einfo "net-im/msn-transport - MSN transport"
	einfo "net-im/jud - Jabber User Directory"
	einfo "net-im/yahoo-transport - Yahoo IM system"
	einfo "net-im/aim-transport - AOL transport"
	einfo "net-im/mu-conference - Jabber multi user conference"
}
