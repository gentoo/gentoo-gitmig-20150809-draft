# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-sork/horde-sork-0.ebuild,v 1.2 2004/03/29 01:43:27 zx Exp $

inherit horde

DESCRIPTION="Sork is comprised of four Horde modules: accounts, forwards, passwd, vacation"
SRC_URI=""

KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND=""
RDEPEND="net-www/horde-accounts
	net-www/horde-forwards
	net-www/horde-passwd
	net-www/horde-vacation"

# this is just a meta package
pkg_setup() { :;}
src_install() { :;}
pkg_postinst() { :;}
